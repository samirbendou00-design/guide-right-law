<!DOCTYPE html>
<html dir="rtl" lang="ar">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>مستشاري القانوني</title>
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@700;900&display=swap" rel="stylesheet">
<style>body{font-family:'Tajawal',sans-serif}</style>
</head>
<body class="bg-slate-50">
<div id="app" class="max-w-[480px] mx-auto min-h-screen pb-20">
<div class="bg-[#064e3b] text-white p-4">
<h1 class="font-black text-xl">⚖️ مستشاري القانوني</h1>
<p class="text-xs opacity-70">لوحة التحكم السرية: /sami1973</p>
</div>
<div class="bg-white m-3 p-4 rounded-2xl shadow">
<select id="country" class="w-full p-3 bg-slate-100 rounded-xl"><option>المغرب</option><option>الجزائر</option><option>مصر</option><option>السعودية</option></select>
<textarea id="q" placeholder="سؤالك القانوني هنا..." class="w-full mt-2 p-3 bg-slate-100 rounded-xl h-20"></textarea>
<button onclick="ask()" class="w-full mt-2 bg-[#064e3b] text-white p-3 rounded-xl font-bold">اسأل الآن</button>
</div>
<div id="list" class="p-3 grid gap-3"></div>
<div class="bg-white border m-3 p-2 text-center text-[10px] text-slate-400">إعلانات AdSense هنا - ca-pub-XXXX</div>
</div>
<script>
let qs=JSON.parse(localStorage.getItem('qs')||'[]');
function render(){
 let isAdmin=location.pathname==='/sami1973';
 if(isAdmin){
   document.body.innerHTML=`<div class='min-h-screen bg-slate-900 text-white p-4'><h1 class='font-black text-xl'>🔐 لوحة سامي السرية</h1><p class='mt-2'>عدد الأسئلة: ${qs.length}</p><div id='a'></div><button onclick="localStorage.clear();location.reload()" class='mt-4 bg-red-600 px-4 py-2 rounded'>مسح الكل</button> <button onclick="location.href='/'" class='bg-slate-700 px-4 py-2 rounded'>رجوع</button></div>`;
   let a=document.getElementById('a');
   qs.forEach(x=>{a.innerHTML+=`<div class='bg-white text-black p-3 rounded-xl mt-2'><div class='text-xs text-slate-500'>${x.country} - ${x.date}</div><div class='font-bold'>${x.question}</div></div>`});
   return;
 }
 let l=document.getElementById('list');
 l.innerHTML=qs.map(x=>`<div class='bg-white p-4 rounded-2xl shadow border-r-4 border-emerald-700'><div class='text-[10px] bg-emerald-50 inline-block px-2 py-1 rounded'>${x.country}</div><div class='font-bold mt-2'>${x.question}</div><div class='text-xs text-slate-400 mt-1'>${x.date}</div></div>`).join('')||"<p class='text-center text-slate-400 text-sm'>لا يوجد أسئلة بعد - كن أول من يسأل</p>";
}
function ask(){
 let qq=document.getElementById('q').value; let c=document.getElementById('country').value;
 if(!qq.trim()) return; qs.unshift({question:qq,country:c,date:new Date().toLocaleString('ar-MA')}); localStorage.setItem('qs',JSON.stringify(qs)); document.getElementById('q').value=''; render();
}
render();
</script>
</body>
</html>
