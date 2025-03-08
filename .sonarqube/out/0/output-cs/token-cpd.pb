ä)
@/Users/gayan/Developer/GasByGas/backend/Services/TokenService.cs
	namespace 	
backend
 
. 
Services 
; 
public

 
class

 
TokenService

 
:

 
ITokenService

 )
{ 
private 
readonly 
IConfiguration #
_configuration$ 2
;2 3
private  
SymmetricSecurityKey  
?  !
_key" &
;& '
private 
readonly 
IKeyVaultService %
_keyVaultService& 6
;6 7
public 

TokenService 
( 
IConfiguration &
configuration' 4
,4 5
IKeyVaultService6 F
keyVaultServiceG V
)V W
{ 
_configuration 
= 
configuration &
;& '
_keyVaultService 
= 
keyVaultService *
;* +
} 
private 
async 
Task 
InitializeKeyAsync )
() *
)* +
{ 
var 

signingKey 
= 
await 
_keyVaultService /
./ 0
GetSecretAsync0 >
(> ?
$str? N
)N O
;O P
if 

( 
string 
. 
IsNullOrEmpty  
(  !

signingKey! +
)+ ,
), -
{ 	
throw 
new %
InvalidOperationException /
(/ 0
$str0 [
)[ \
;\ ]
} 	
_key   
=   
new    
SymmetricSecurityKey   '
(  ' (
Encoding  ( 0
.  0 1
UTF8  1 5
.  5 6
GetBytes  6 >
(  > ?

signingKey  ? I
)  I J
)  J K
;  K L
}!! 
public## 

async## 
Task## 
<## 
string## 
>## 
CreateToken## )
(##) *
AppUser##* 1
user##2 6
)##6 7
{$$ 
if&& 

(&& 
_key&& 
==&& 
null&& 
)&& 
{'' 	
await(( 
InitializeKeyAsync(( $
((($ %
)((% &
;((& '
})) 	
var** 
claims** 
=** 
new** 
List** 
<** 
Claim** #
>**# $
{++ 	
new,, 
Claim,, 
(,, #
JwtRegisteredClaimNames,, -
.,,- .
Email,,. 3
,,,3 4
user,,5 9
.,,9 :
Email,,: ?
??,,@ B
throw,,C H
new,,I L%
InvalidOperationException,,M f
(,,f g
),,g h
),,h i
,,,i j
new-- 
Claim-- 
(-- #
JwtRegisteredClaimNames-- -
.--- .
Name--. 2
,--2 3
user--4 8
.--8 9
FullName--9 A
??--B D
throw--E J
new--K N%
InvalidOperationException--O h
(--h i
)--i j
)--j k
,--k l
new.. 
Claim.. 
(.. #
JwtRegisteredClaimNames.. -
...- .
PhoneNumber... 9
,..9 :
user..; ?
...? @
PhoneNumber..@ K
??..L N
throw..O T
new..U X%
InvalidOperationException..Y r
(..r s
)..s t
)..t u
,..u v
}00 	
;00	 

var22 
credentials22 
=22 
new22 
SigningCredentials22 0
(220 1
_key221 5
,225 6
SecurityAlgorithms227 I
.22I J
HmacSha512Signature22J ]
)22] ^
;22^ _
var33 
tokenDescription33 
=33 
new33 "#
SecurityTokenDescriptor33# :
{44 	
Subject55 
=55 
new55 
ClaimsIdentity55 (
(55( )
claims55) /
)55/ 0
,550 1
Expires66 
=66 
DateTime66 
.66 
UtcNow66 %
.66% &
AddDays66& -
(66- .
$num66. 0
)660 1
,661 2
SigningCredentials77 
=77  
credentials77! ,
,77, -
Issuer88 
=88 
_configuration88 #
[88# $
$str88$ 0
]880 1
,881 2
Audience99 
=99 
_configuration99 %
[99% &
$str99& 4
]994 5
}:: 	
;::	 

var;; 
tokenHandler;; 
=;; 
new;; #
JwtSecurityTokenHandler;; 6
(;;6 7
);;7 8
;;;8 9
var<< 
token<< 
=<< 
tokenHandler<<  
.<<  !
CreateToken<<! ,
(<<, -
tokenDescription<<- =
)<<= >
;<<> ?
return== 
tokenHandler== 
.== 

WriteToken== &
(==& '
token==' ,
)==, -
;==- .
}>> 
}?? ñ)
>/Users/gayan/Developer/GasByGas/backend/Services/SmsService.cs
	namespace 	
backend
 
. 
Services 
; 
public

 
class

 

SmsService

 
:

 
ISmsService

 %
{ 
private 
const 
string 
apiUrl 
=  !
$str" I
;I J
private 
const 
string 
userId 
=  !
$str" .
;. /
private 
readonly 
IKeyVaultService %
_keyVaultService& 6
;6 7
private  
SymmetricSecurityKey  
?  !
_key" &
;& '
private 
string 
? 
_secret 
; 
public 


SmsService 
( 
IKeyVaultService &
keyVaultService' 6
)6 7
{ 
_keyVaultService 
= 
keyVaultService *
;* +
} 
private 
async 
Task 
InitializeKeyAsync )
() *
)* +
{ 
var 
smskey 
= 
await 
_keyVaultService +
.+ ,
GetSecretAsync, :
(: ;
$str; F
)F G
;G H
if 

( 
string 
. 
IsNullOrEmpty  
(  !
smskey! '
)' (
)( )
{ 	
throw 
new %
InvalidOperationException /
(/ 0
$str0 _
)_ `
;` a
}   	
_key"" 
="" 
new""  
SymmetricSecurityKey"" '
(""' (
Encoding""( 0
.""0 1
UTF8""1 5
.""5 6
GetBytes""6 >
(""> ?
smskey""? E
)""E F
)""F G
;""G H
_secret## 
=## 
smskey## 
;## 
}$$ 
public&& 

async&& 
Task&& 
<&& 
bool&& 
>&& 
SendSmsAsync&& (
(&&( )
string&&) /
	recipient&&0 9
,&&9 :
string&&; A
message&&B I
)&&I J
{'' 
if(( 

((( 
_key(( 
==(( 
null(( 
)(( 
{)) 	
await** 
InitializeKeyAsync** $
(**$ %
)**% &
;**& '
}++ 	
using-- 

HttpClient-- 
client-- 
=--  !
new--" %

HttpClient--& 0
(--0 1
)--1 2
;--2 3
string// 

requestUri// 
=// 
$"00 
{00 
apiUrl00 
}00 
$str00 !
{00! "
	recipient00" +
}00+ ,
$str00, 7
{007 8
userId008 >
}00> ?
$str00? H
{00H I
Uri00I L
.00L M
EscapeDataString00M ]
(00] ^
message00^ e
)00e f
}00f g
$str00g r
{00r s
_secret00s z
}00z {
"00{ |
;00| }
Console11 
.11 
	WriteLine11 
(11 

requestUri11 $
)11$ %
;11% &
try22 
{33 	
HttpResponseMessage44 
response44  (
=44) *
await44+ 0
client441 7
.447 8
GetAsync448 @
(44@ A

requestUri44A K
)44K L
;44L M
string55 
responseString55 !
=55" #
await55$ )
response55* 2
.552 3
Content553 :
.55: ;
ReadAsStringAsync55; L
(55L M
)55M N
;55N O
var77 
jsonResponse77 
=77 
JsonSerializer77 -
.77- .
Deserialize77. 9
<779 :
JsonElement77: E
>77E F
(77F G
responseString77G U
)77U V
;77V W
string88 
status88 
=88 
jsonResponse88 (
.88( )
GetProperty88) 4
(884 5
$str885 =
)88= >
.88> ?
	GetString88? H
(88H I
)88I J
??88K M
throw88N S
new88T W%
InvalidOperationException88X q
(88q r
$str	88r ï
)
88ï ñ
;
88ñ ó
Console99 
.99 
	WriteLine99 
(99 
responseString99 ,
)99, -
;99- .
return:: 
status:: 
==:: 
$str:: &
;::& '
};; 	
catch<< 
(<< 
	Exception<< 
e<< 
)<< 
{== 	
Console>> 
.>> 
	WriteLine>> 
(>> 
e>> 
)>>  
;>>  !
Console?? 
.?? 
	WriteLine?? 
(?? 
e?? 
.??  
Message??  '
)??' (
;??( )
return@@ 
false@@ 
;@@ 
}AA 	
}BB 
}CC À=
D/Users/gayan/Developer/GasByGas/backend/Services/SchedulerService.cs
	namespace

 	
backend


 
.

 
Services

 
{ 
public 

class 
SchedulerService !
:" #
BackgroundService$ 5
{ 
private 
readonly 
IServiceProvider )
_serviceProvider* :
;: ;
private 
readonly 
ILogger  
<  !
SchedulerService! 1
>1 2
_logger3 :
;: ;
private 
readonly 
TimeSpan !
_executionTime" 0
=1 2
TimeSpan3 ;
.; <
	FromHours< E
(E F
$numF G
)G H
;H I
public 
SchedulerService 
(  
IServiceProvider  0
serviceProvider1 @
,@ A
ILoggerB I
<I J
SchedulerServiceJ Z
>Z [
logger\ b
)b c
{ 	
_serviceProvider 
= 
serviceProvider .
;. /
_logger 
= 
logger 
; 
} 	
	protected 
override 
async  
Task! %
ExecuteAsync& 2
(2 3
CancellationToken3 D
stoppingTokenE R
)R S
{ 	
_logger 
. 
LogInformation "
(" #
$str# E
)E F
;F G
while 
( 
! 
stoppingToken !
.! "#
IsCancellationRequested" 9
)9 :
{ 
try 
{ 
DateTime   
now    
=  ! "
DateTime  # +
.  + ,
UtcNow  , 2
;  2 3
DateTime!! 
nextRunTime!! (
=!!) *
now!!+ .
.!!. /
Date!!/ 3
.!!3 4
Add!!4 7
(!!7 8
_executionTime!!8 F
)!!F G
;!!G H
if## 
(## 
now## 
>=## 
nextRunTime## *
)##* +
{$$ 
nextRunTime%% #
=%%$ %
nextRunTime%%& 1
.%%1 2
AddDays%%2 9
(%%9 :
$num%%: ;
)%%; <
;%%< =
}&& 
TimeSpan(( 
delay(( "
=((# $
nextRunTime((% 0
-((1 2
now((3 6
;((6 7
_logger)) 
.)) 
LogInformation)) *
())* +
$"))+ -
$str))- J
{))J K
nextRunTime))K V
}))V W
$str))W \
"))\ ]
)))] ^
;))^ _
await++ 
Task++ 
.++ 
Delay++ $
(++$ %
delay++% *
,++* +
stoppingToken++, 9
)++9 :
;++: ;
await-- &
SendDeliveryReminderEmails-- 4
(--4 5
)--5 6
;--6 7
}.. 
catch// 
(// !
TaskCanceledException// ,
)//, -
{00 
_logger11 
.11 
LogInformation11 *
(11* +
$str11+ M
)11M N
;11N O
break22 
;22 
}33 
catch44 
(44 
	Exception44  
ex44! #
)44# $
{55 
_logger66 
.66 
LogError66 $
(66$ %
ex66% '
,66' (
$str66) X
)66X Y
;66Y Z
}77 
}88 
}99 	
public;; 
async;; 
Task;; 
RunNow;;  
(;;  !
);;! "
{<< 	
_logger== 
.== 
LogInformation== "
(==" #
$str==# K
)==K L
;==L M
await>> &
SendDeliveryReminderEmails>> ,
(>>, -
)>>- .
;>>. /
}?? 	
privateAA 
asyncAA 
TaskAA &
SendDeliveryReminderEmailsAA 5
(AA5 6
)AA6 7
{BB 	
usingCC 
(CC 
varCC 
scopeCC 
=CC 
_serviceProviderCC /
.CC/ 0
CreateScopeCC0 ;
(CC; <
)CC< =
)CC= >
{DD 
varEE 
gasTokenRepoEE  
=EE! "
scopeEE# (
.EE( )
ServiceProviderEE) 8
.EE8 9
GetRequiredServiceEE9 K
<EEK L
IGasTokenRepositoryEEL _
>EE_ `
(EE` a
)EEa b
;EEb c
varFF 
mailServiceFF 
=FF  !
scopeFF" '
.FF' (
ServiceProviderFF( 7
.FF7 8
GetRequiredServiceFF8 J
<FFJ K
IMailServiceFFK W
>FFW X
(FFX Y
)FFY Z
;FFZ [
varGG 
deliveryRepoGG  
=GG! "
scopeGG# (
.GG( )
ServiceProviderGG) 8
.GG8 9
GetRequiredServiceGG9 K
<GGK L
IDeliveryRepositoryGGL _
>GG_ `
(GG` a
)GGa b
;GGb c
varII 
tomorrowII 
=II 
DateOnlyII '
.II' (
FromDateTimeII( 4
(II4 5
DateTimeII5 =
.II= >
UtcNowII> D
.IID E
AddDaysIIE L
(IIL M
$numIIM N
)IIN O
)IIO P
;IIP Q
varJJ 
confirmedDeliveriesJJ '
=JJ( )
awaitJJ* /
deliveryRepoJJ0 <
.JJ< =)
GetConfirmedDeliveriesForDateJJ= Z
(JJZ [
tomorrowJJ[ c
)JJc d
;JJd e
foreachLL 
(LL 
varLL 
deliveryLL %
inLL& (
confirmedDeliveriesLL) <
)LL< =
{MM 
varNN 
	gasTokensNN !
=NN" #
awaitNN$ )
gasTokenRepoNN* 6
.NN6 71
%GetGasTokensByDeliveryScheduleIdAsyncNN7 \
(NN\ ]
deliveryNN] e
.NNe f
IdNNf h
)NNh i
;NNi j
varOO 
emailAddressesOO &
=OO' (
	gasTokensOO) 2
.OO2 3
SelectOO3 9
(OO9 :
gOO: ;
=>OO< >
gOO? @
.OO@ A
	UserEmailOOA J
)OOJ K
.OOK L
DistinctOOL T
(OOT U
)OOU V
.OOV W
ToListOOW ]
(OO] ^
)OO^ _
;OO_ `
foreachQQ 
(QQ 
varQQ  
emailQQ! &
inQQ' )
emailAddressesQQ* 8
)QQ8 9
{RR 
stringSS 
subjectSS &
=SS' (
$strSS) I
;SSI J
stringTT 
bodyTT #
=TT$ %
$"TT& (
$strTT( J
{TTJ K
deliveryTTK S
.TTS T
DeliveryDateTTT `
:TT` a
$strTTa s
}TTs t
$strTTt v
"TTv w
+TTx y
$"UU& (
$strUU( c
"UUc d
;UUd e
awaitWW 
mailServiceWW )
.WW) *
SendEmailAsyncWW* 8
(WW8 9
emailWW9 >
,WW> ?
$strWW@ K
,WWK L
subjectWWM T
,WWT U
bodyWWV Z
)WWZ [
;WW[ \
_loggerXX 
.XX  
LogInformationXX  .
(XX. /
$"XX/ 1
$strXX1 Q
{XXQ R
emailXXR W
}XXW X
$strXXX p
{XXp q
deliveryXXq y
.XXy z
IdXXz |
}XX| }
$strXX} ~
"XX~ 
)	XX Ä
;
XXÄ Å
}YY 
}ZZ 
_logger\\ 
.\\ 
LogInformation\\ &
(\\& '
$str\\' M
)\\M N
;\\N O
}]] 
}^^ 	
}__ 
}`` õ2
?/Users/gayan/Developer/GasByGas/backend/Services/MailService.cs
	namespace 	
backend
 
. 
Services 
; 
public 
class 
MailService 
: 
IMailService &
{		 
private

 
readonly

 
IKeyVaultService

 %
_keyVaultService

& 6
;

6 7
private 
string 
? 
_emailApiKey  
;  !
private 
string 
? 
_emailApiSecret #
;# $
public 

MailService 
( 
IKeyVaultService '
keyVaultService( 7
)7 8
{ 
_keyVaultService 
= 
keyVaultService *
;* +
} 
private 
async 
Task 
InitializeKeyAsync )
() *
)* +
{ 
var 
emailKey 
= 
await 
_keyVaultService -
.- .
GetSecretAsync. <
(< =
$str= J
)J K
;K L
var 
emailSecret 
= 
await 
_keyVaultService  0
.0 1
GetSecretAsync1 ?
(? @
$str@ L
)L M
;M N
if 

( 
string 
. 
IsNullOrEmpty  
(  !
emailKey! )
)) *
||+ -
string. 4
.4 5
IsNullOrEmpty5 B
(B C
emailSecretC N
)N O
)O P
{ 	
throw 
new %
InvalidOperationException /
(/ 0
$str0 c
)c d
;d e
} 	
_emailApiKey 
= 
emailKey 
;  
_emailApiSecret 
= 
emailSecret %
;% &
}   
public"" 

async"" 
Task"" 
<"" 
bool"" 
>"" 
SendEmailAsync"" *
(""* +
string""+ 1
toEmail""2 9
,""9 :
string""; A
toName""B H
,""H I
string""J P
subject""Q X
,""X Y
string""Z `
body""a e
)""e f
{## 
if$$ 

($$ 
_emailApiKey$$ 
==$$ 
null$$  
||$$! #
_emailApiSecret$$$ 3
==$$4 6
null$$7 ;
)$$; <
{%% 	
await&& 
InitializeKeyAsync&& $
(&&$ %
)&&% &
;&&& '
}'' 	
MailjetClient)) 
mailjetClient)) #
=))$ %
new))& )
MailjetClient))* 7
())7 8
_emailApiKey))8 D
,))D E
_emailApiSecret))F U
)))U V
;))V W
MailjetRequest++ 
emailRequest++ #
=++$ %
new++& )
MailjetRequest++* 8
{,, 
Resource-- 
=-- 
Send-- 
.--  
Resource--  (
,--( )
}.. 
.// 
Property// 
(// 
Send// 
.// 
	FromEmail// $
,//$ %
$str//& 9
)//9 :
.00 
Property00 
(00 
Send00 
.00 
FromName00 #
,00# $
$str00% /
)00/ 0
.11 
Property11 
(11 
Send11 
.11 
Subject11 "
,11" #
subject11$ +
)11+ ,
.22 
Property22 
(22 
Send22 
.22 
TextPart22 #
,22# $
body22% )
)22) *
.33 
Property33 
(33 
Send33 
.33 
HtmlPart33 #
,33# $
body33% )
)33) *
.44 
Property44 
(44 
Send44 
.44 

Recipients44 %
,44% &
new44' *
JArray44+ 1
{55 
new66 
JObject66 
{77 
{88 
$str88 
,88 
toEmail88 %
}88% &
}99 
}:: 
):: 
;:: 
MailjetResponse<< 
emailResponse<< %
=<<& '
await<<( -
mailjetClient<<. ;
.<<; <
	PostAsync<<< E
(<<E F
emailRequest<<F R
)<<R S
;<<S T
if== 

(== 
emailResponse== 
.== 
IsSuccessStatusCode== -
)==- .
{>> 	
Console?? 
.?? 
	WriteLine?? 
(?? 
$str?? *
)??* +
;??+ ,
Console@@ 
.@@ 
	WriteLine@@ 
(@@ 
emailResponse@@ +
.@@+ ,
GetData@@, 3
(@@3 4
)@@4 5
)@@5 6
;@@6 7
returnAA 
trueAA 
;AA 
}CC 	
elseDD 
{EE 	
ConsoleFF 
.FF 
	WriteLineFF 
(FF 
$strFF 1
)FF1 2
;FF2 3
ConsoleGG 
.GG 
	WriteLineGG 
(GG 
$"GG  
$strGG  ,
{GG, -
emailResponseGG- :
.GG: ;

StatusCodeGG; E
}GGE F
$strGGF H
"GGH I
)GGI J
;GGJ K
ConsoleHH 
.HH 
	WriteLineHH 
(HH 
$"HH  
$strHH  +
{HH+ ,
emailResponseHH, 9
.HH9 :
GetErrorInfoHH: F
(HHF G
)HHG H
}HHH I
$strHHI K
"HHK L
)HHL M
;HHM N
ConsoleII 
.II 
	WriteLineII 
(II 
emailResponseII +
.II+ ,
GetDataII, 3
(II3 4
)II4 5
)II5 6
;II6 7
ConsoleJJ 
.JJ 
	WriteLineJJ 
(JJ 
$"JJ  
$strJJ  .
{JJ. /
emailResponseJJ/ <
.JJ< =
GetErrorMessageJJ= L
(JJL M
)JJM N
}JJN O
$strJJO Q
"JJQ R
)JJR S
;JJS T
returnKK 
falseKK 
;KK 
}MM 	
}PP 
}QQ ˜
C/Users/gayan/Developer/GasByGas/backend/Services/KeyVaultService.cs
	namespace 	
backend
 
. 
Services 
; 
public 
class 
KeyVaultService 
: 
IKeyVaultService /
{ 
private		 
readonly		 
SecretClient		 !
_secretClient		" /
;		/ 0
public 

KeyVaultService 
( 
IConfiguration )
configuration* 7
)7 8
{ 
var 
keyVaultUri 
= 
configuration '
[' (
$str( @
]@ A
;A B
if 

( 
string 
. 
IsNullOrEmpty  
(  !
keyVaultUri! ,
), -
)- .
{ 	
throw 
new 
ArgumentException '
(' (
$str( P
)P Q
;Q R
} 	
_secretClient 
= 
new 
SecretClient (
(( )
new) ,
Uri- 0
(0 1
keyVaultUri1 <
)< =
,= >
new? B"
DefaultAzureCredentialC Y
(Y Z
)Z [
)[ \
;\ ]
} 
public 

async 
Task 
< 
string 
> 
GetSecretAsync ,
(, -
string- 3

secretName4 >
)> ?
{ 
KeyVaultSecret 
secret 
= 
await  %
_secretClient& 3
.3 4
GetSecretAsync4 B
(B C

secretNameC M
)M N
;N O
return 
secret 
. 
Value 
; 
} 
} Ò
D/Users/gayan/Developer/GasByGas/backend/Services/EnumSchemaFilter.cs
	namespace 	
backend
 
. 
Services 
; 
public 
class 
EnumSchemaFilter 
: 
ISchemaFilter ,
{		 
public

 

void

 
Apply

 
(

 
OpenApiSchema

 #
model

$ )
,

) *
SchemaFilterContext

+ >
context

? F
)

F G
{ 
if 

( 
context 
. 
Type 
. 
IsEnum 
)  
{ 	
model 
. 
Enum 
. 
Clear 
( 
) 
; 
foreach 
( 
string 
enumName $
in% '
Enum( ,
., -
GetNames- 5
(5 6
context6 =
.= >
Type> B
)B C
)C D
{ 
System 
. 

Reflection !
.! "

MemberInfo" ,

memberInfo- 7
=8 9
context: A
.A B
TypeB F
.F G
	GetMemberG P
(P Q
enumNameQ Y
)Y Z
.Z [
FirstOrDefault[ i
(i j
mj k
=>l n
mo p
.p q
DeclaringTypeq ~
==	 Å
context
Ç â
.
â ä
Type
ä é
)
é è
;
è ê
EnumMemberAttribute #
enumMemberAttribute$ 7
=8 9

memberInfo: D
==E G
nullH L
? 
null 
: 

memberInfo  
.  !
GetCustomAttributes! 4
(4 5
typeof5 ;
(; <
EnumMemberAttribute< O
)O P
,P Q
falseR W
)W X
.X Y
OfTypeY _
<_ `
EnumMemberAttribute` s
>s t
(t u
)u v
.v w
FirstOrDefault	w Ö
(
Ö Ü
)
Ü á
;
á à
string 
label 
= 
enumMemberAttribute 2
==3 5
null6 :
||; =
string> D
.D E
IsNullOrWhiteSpaceE W
(W X
enumMemberAttributeX k
.k l
Valuel q
)q r
? 
enumName 
: 
enumMemberAttribute )
.) *
Value* /
;/ 0
model 
. 
Enum 
. 
Add 
( 
new "
OpenApiString# 0
(0 1
label1 6
)6 7
)7 8
;8 9
} 
} 	
} 
} Æ8
G/Users/gayan/Developer/GasByGas/backend/Repositories/StockRepository.cs
	namespace 	
backend
 
. 
Repositories 
; 
public		 
class		 
StockRepository		 
:		 
IStockRepository		 .
{

 
private 
readonly  
ApplicationDbContext )
_context* 2
;2 3
public 

StockRepository 
(  
ApplicationDbContext /
context0 7
)7 8
{ 
_context 
= 
context 
; 
} 
public 

async 
Task 
< 
List 
< 
StockRequest '
>' (
>( )$
GetAllStockRequestsAsync* B
(B C
)C D
{ 
return 
await 
_context 
. 
StockRequests +
.+ ,
ToListAsync, 7
(7 8
)8 9
;9 :
} 
public 

async 
Task 
< 
List 
< 
StockRequest '
>' (
>( ).
"GetAllStockRequestsByOutletIdAsync* L
(L M
intM P
outletIdQ Y
)Y Z
{ 
return 
await 
_context 
. 
StockRequests +
.+ ,
Where, 1
(1 2
s2 3
=>4 6
s7 8
.8 9
OutletId9 A
==B D
outletIdE M
)M N
.N O
ToListAsyncO Z
(Z [
)[ \
;\ ]
} 
public 

async 
Task 
< 
StockRequest "
?" #
># $$
GetStockRequestByIdAsync% =
(= >
int> A
idB D
)D E
{ 
return 
await 
_context 
. 
StockRequests +
.+ ,
	FindAsync, 5
(5 6
id6 8
)8 9
;9 :
} 
public!! 

async!! 
Task!! 
<!! 
List!! 
<!! 
StockRequest!! '
>!!' (
>!!( )0
$GetAllStockRequestsByDeliveryIdAsync!!* N
(!!N O
int!!O R

deliveryId!!S ]
)!!] ^
{"" 
return## 
await## 
_context## 
.## 
StockRequests## +
.##+ ,
Where##, 1
(##1 2
s##2 3
=>##3 5
s##6 7
.##7 8
DeliveryScheduleId##8 J
==##K M

deliveryId##N X
)##X Y
.##Y Z
ToListAsync##Z e
(##e f
)##f g
;##g h
}$$ 
public&& 

async&& 
Task&& 
<&& 
StockRequest&& "
?&&" #
>&&# $#
CreateStockRequestAsync&&% <
(&&< =
StockRequest&&= I
stockRequestModel&&J [
)&&[ \
{'' 
await(( 
_context(( 
.(( 
StockRequests(( #
.((# $
AddAsync(($ ,
(((, -
stockRequestModel((- >
)((> ?
;((? @
await)) 
_context)) 
.)) 
SaveChangesAsync)) &
())& '
)))' (
;))( )
return** 
stockRequestModel** 
;**  
}++ 
public-- 

async-- 
Task-- 
<-- 
StockRequest-- "
?--" #
>--# $#
UpdateStockRequestAsync--% <
(--< =
int--= @
id--A C
,--C D(
StockRequestUpdateRequestDto--E a
updateRequest--b o
)--o p
{.. 
var// 
stockRequestModel// 
=// 
await//  %
_context//& .
.//. /
StockRequests/// <
.//< =
	FindAsync//= F
(//F G
id//G I
)//I J
;//J K
if11 

(11 
stockRequestModel11 
==11  
null11! %
)11% &
return11' -
null11. 2
;112 3
stockRequestModel33 
.33 
	Completed33 #
=33$ %
stockRequestModel33& 7
.337 8
	Completed338 A
;33A B
stockRequestModel44 
.44 
CompletedDate44 '
=44( )
stockRequestModel44* ;
.44; <
CompletedDate44< I
;44I J
stockRequestModel55 
.55 
NoOfUnitsDispatched55 -
=55. /
stockRequestModel550 A
.55A B
NoOfUnitsDispatched55B U
;55U V
stockRequestModel66 
.66 
DeliveryScheduleId66 ,
=66- .
updateRequest66/ <
.66< =
DeliveryScheduleId66= O
;66O P
if88 

(88 
updateRequest88 
.88 
OutletId88 "
!=88# %
stockRequestModel88& 7
.887 8
OutletId888 @
&&88A C
updateRequest88D Q
.88Q R
OutletId88R Z
!=88[ ]
null88^ b
)88b c
{99 	
Console:: 
.:: 
	WriteLine:: 
(:: 
$"::  
$str::  7
{::7 8
stockRequestModel::8 I
.::I J
OutletId::J R
}::R S
$str::S W
{::W X
updateRequest::X e
.::e f
OutletId::f n
}::n o
"::o p
)::p q
;::q r
stockRequestModel;; 
.;; 
OutletId;; &
=;;' (
(;;) *
int;;* -
);;- .
updateRequest;;. ;
.;;; <
OutletId;;< D
!;;D E
;;;E F
}<< 	
await?? 
_context?? 
.?? 
SaveChangesAsync?? '
(??' (
)??( )
;??) *
return@@ 
stockRequestModel@@  
;@@  !
}AA 
publicCC 

asyncCC 
TaskCC 
<CC 
StockRequestCC "
?CC" #
>CC# $#
DeleteStockRequestAsyncCC% <
(CC< =
intCC= @
idCCA C
)CCC D
{DD 
varEE 
stockRequestEE 
=EE 
awaitEE  
_contextEE! )
.EE) *
StockRequestsEE* 7
.EE7 8
	FindAsyncEE8 A
(EEA B
idEEB D
)EED E
;EEE F
ifGG 

(GG 
stockRequestGG 
==GG 
nullGG  
)GG  !
{HH 	
returnII 
nullII 
;II 
}JJ 	
_contextLL 
.LL 
RemoveLL 
(LL 
stockRequestLL $
)LL$ %
;LL% &
awaitMM 
_contextMM 
.MM 
SaveChangesAsyncMM '
(MM' (
)MM( )
;MM) *
returnNN 
stockRequestNN 
;NN 
}OO 
}PP ˙
H/Users/gayan/Developer/GasByGas/backend/Repositories/OutletRepository.cs
	namespace 	
backend
 
. 
Repositories 
; 
public 
class 
OutletRepository 
: 
IOutletRepository  1
{		 
private

 
readonly

  
ApplicationDbContext

 )
_context

* 2
;

2 3
public 

OutletRepository 
(  
ApplicationDbContext 0
context1 8
)8 9
{ 
_context 
= 
context 
; 
} 
public 

async 
Task 
< 
List 
< 
Outlet !
>! "
>" #
GetAllOutletsAsync$ 6
(6 7
)7 8
{ 
return 
await 
_context 
. 
Outlets %
.% &
ToListAsync& 1
(1 2
)2 3
;3 4
} 
public 

async 
Task 
< 
Outlet 
> 
GetOutletByIdAsync 0
(0 1
int1 4
id5 7
)7 8
{ 
return 
await 
_context 
. 
Outlets %
.% &
FirstOrDefaultAsync& 9
(9 :
x: ;
=>< >
x? @
.@ A
IdA C
==D F
idG I
)I J
;J K
} 
public 

async 
Task 
< 
bool 
> 
OutletExists (
(( )
int) ,
id- /
)/ 0
{ 
return 
await 
_context 
. 
Outlets %
.% &
AnyAsync& .
(. /
x/ 0
=>1 3
x4 5
.5 6
Id6 8
==9 ;
id< >
)> ?
;? @
} 
public 

async 
Task 
< 
Outlet 
> 
CreateOutletAsync /
(/ 0
Outlet0 6
outletModel7 B
)B C
{   
await!!	 
_context!! 
.!! 
Outlets!! 
.!!  
AddAsync!!  (
(!!( )
outletModel!!) 4
)!!4 5
;!!5 6
await""	 
_context"" 
."" 
SaveChangesAsync"" (
(""( )
)"") *
;""* +
return##	 
outletModel## 
;## 
}$$ 
public&& 

async&& 
Task&& 
<&& 
bool&& 
>&& 
DeleteOutletAsync&& -
(&&- .
int&&. 1
id&&2 4
)&&4 5
{'' 
var(( 
outlet(( 
=(( 
await(( 
_context(( #
.((# $
Outlets(($ +
.((+ ,
	FindAsync((, 5
(((5 6
id((6 8
)((8 9
;((9 :
if)) 

()) 
outlet)) 
==)) 
null)) 
))) 
return)) "
false))# (
;))( )
_context++ 
.++ 
Outlets++ 
.++ 
Remove++ 
(++  
outlet++  &
)++& '
;++' (
await,, 
_context,, 
.,, 
SaveChangesAsync,, '
(,,' (
),,( )
;,,) *
return-- 
true-- 
;-- 
}.. 
}// T
J/Users/gayan/Developer/GasByGas/backend/Repositories/GasTokenRepository.cs
	namespace 	
backend
 
. 
Repositories 
; 
public

 
class

 
GasTokenRepository

 
:

  !
IGasTokenRepository

" 5
{ 
private 
readonly  
ApplicationDbContext )
_context* 2
;2 3
private 
readonly 
IMailService !
_mailService" .
;. /
private 
readonly 
ISmsService  
_smsService! ,
;, -
public 

GasTokenRepository 
(  
ApplicationDbContext 2
context3 :
,: ;
IMailService< H
mailServiceI T
,T U
ISmsServiceV a

smsServiceb l
)l m
{ 
_context 
= 
context 
; 
_mailService 
= 
mailService "
;" #
_smsService 
= 

smsService  
;  !
} 
public 

async 
Task 
< 
List 
< 
GasToken #
># $
>$ %
GetAllAsync& 1
(1 2
)2 3
{ 
return 
await 
_context 
. 
	GasTokens '
.' (
ToListAsync( 3
(3 4
)4 5
;5 6
} 
public 

async 
Task 
< 
GasToken 
> 
CreateAsync  +
(+ ,
GasToken, 4
gasTokenModel5 B
)B C
{ 
await 
_context 
. 
	GasTokens  
.  !
AddAsync! )
() *
gasTokenModel* 7
)7 8
;8 9
await 
_context 
. 
SaveChangesAsync '
(' (
)( )
;) *
return   
gasTokenModel   
;   
}!! 
public## 

async## 
Task## 
<## 
GasToken## 
?## 
>##  
GetByIdAsync##! -
(##- .
int##. 1
id##2 4
)##4 5
{$$ 
return%% 
await%% 
_context%% 
.%% 
	GasTokens%% '
.%%' (
FirstOrDefaultAsync%%( ;
(%%; <
x%%< =
=>%%> @
x%%A B
.%%B C
Id%%C E
==%%F H
id%%I K
)%%K L
;%%L M
}&& 
public(( 

async(( 
Task(( 
<(( 
List(( 
<(( 
GasToken(( #
>((# $
>(($ %
GetAllByEmailAsync((& 8
(((8 9
string((9 ?
email((@ E
)((E F
{)) 
return** 
await** 
_context** 
.** 
	GasTokens** '
.**' (
Where**( -
(**- .
x**. /
=>**0 2
x**3 4
.**4 5
	UserEmail**5 >
==**? A
email**B G
)**G H
.**H I
ToListAsync**I T
(**T U
)**U V
;**V W
}++ 
public-- 

async-- 
Task-- 
<-- 
List-- 
<-- 
GasToken-- #
>--# $
>--$ %
GetAllByOutletAsync--& 9
(--9 :
int--: =
outletId--> F
)--F G
{.. 
return// 
await// 
_context// 
.// 
	GasTokens// '
.//' (
Where//( -
(//- .
x//. /
=>//0 2
x//3 4
.//4 5
OutletId//5 =
==//> @
outletId//A I
)//I J
.//J K
ToListAsync//K V
(//V W
)//W X
;//X Y
}00 
public33 

async33 
Task33 
<33 
GasToken33 
?33 
>33  *
UpdateExpectedDateOfTokenAsync33! ?
(33? @
int33@ C
id33D F
,33F G!
CreateTokenRequestDto33H ]
createTokenDto33^ l
)33l m
{44 
var55 

tokenModel55 
=55 
await55 
_context55 '
.55' (
	GasTokens55( 1
.551 2
FirstOrDefaultAsync552 E
(55E F
x55F G
=>55H J
x55K L
.55L M
Id55M O
==55P R
id55S U
)55U V
;55V W
if66 

(66 

tokenModel66 
==66 
null66 
)66 
{77 	
return88 
null88 
;88 
}99 	

tokenModel;; 
.;; 
ExpectedPickupDate;; %
=;;& '
createTokenDto;;( 6
.;;6 7
ExpectedPickupDate;;7 I
;;;I J
await<< 
_mailService<< 
.<< 
SendEmailAsync<< )
(<<) *

tokenModel<<* 4
.<<4 5
	UserEmail<<5 >
,<<> ?
$str<<@ K
,<<K L
$str<<M f
,<<f g
$"== 
$str== &
{==& '

tokenModel==' 1
.==1 2
ExpectedPickupDate==2 D
}==D E
"==E F
)==F G
;==G H
await@@ 
_context@@ 
.@@ 
SaveChangesAsync@@ '
(@@' (
)@@( )
;@@) *
returnAA 

tokenModelAA 
;AA 
}BB 
publicDD 

asyncDD 
TaskDD 
<DD 
GasTokenDD 
?DD 
>DD  
UpdateTokenAsyncDD! 1
(DD1 2
intDD2 5
idDD6 8
,DD8 9
UpdateTokenDtoDD: H
updateTokenDtoDDI W
)DDW X
{EE 
varFF 

tokenModelFF 
=FF 
awaitFF 
_contextFF '
.FF' (
	GasTokensFF( 1
.FF1 2
FirstOrDefaultAsyncFF2 E
(FFE F
xFFF G
=>FFH J
xFFK L
.FFL M
IdFFM O
==FFP R
idFFS U
)FFU V
;FFV W
ifHH 

(HH 

tokenModelHH 
==HH 
nullHH 
)HH 
{II 	
returnJJ 
nullJJ 
;JJ 
}KK 	

tokenModelMM 
.MM 
	ReadyDateMM 
=MM 
updateTokenDtoMM -
.MM- .
	ReadyDateMM. 7
;MM7 8

tokenModelNN 
.NN 
ExpectedPickupDateNN %
=NN& '
updateTokenDtoNN( 6
.NN6 7
ExpectedPickupDateNN7 I
;NNI J

tokenModelOO 
.OO 
StatusOO 
=OO 
updateTokenDtoOO *
.OO* +
StatusOO+ 1
;OO1 2

tokenModelPP 
.PP  
IsEmptyCylinderGivenPP '
=PP( )
updateTokenDtoPP* 8
.PP8 9#
IsEmpltyCylindersGiventPP9 P
;PPP Q

tokenModelQQ 
.QQ 
IsPaidQQ 
=QQ 
updateTokenDtoQQ *
.QQ* +
IsPaidQQ+ 1
;QQ1 2

tokenModelRR 
.RR 
PaymentDateRR 
=RR  
updateTokenDtoRR! /
.RR/ 0
PaymentDateRR0 ;
;RR; <

tokenModelSS 
.SS 
	UserEmailSS 
=SS 
updateTokenDtoSS -
.SS- .
	UserEmailSS. 7
;SS7 8

tokenModelTT 
.TT 
DeliveryScheduleIdTT %
=TT& '
updateTokenDtoTT( 6
.TT6 7
DeliveryScheduleIdTT7 I
;TTI J
awaitVV 
_contextVV 
.VV 
SaveChangesAsyncVV '
(VV' (
)VV( )
;VV) *
stringXX 
messageXX 
=XX 
$"XX 
$strXX 
"XX 
+XX 
$"YY 
$strYY W
"YYW X
+YYY Z
$"ZZ 
$strZZ '
{ZZ' (

tokenModelZZ( 2
.ZZ2 3
	ReadyDateZZ3 <
}ZZ< =
"ZZ= >
+ZZ? @
$"[[ 
$str[[ 1
{[[1 2

tokenModel[[2 <
.[[< =
ExpectedPickupDate[[= O
}[[O P
"[[P Q
;[[Q R
await^^ 
_mailService^^ 
.^^ 
SendEmailAsync^^ )
(^^) *

tokenModel^^* 4
.^^4 5
	UserEmail^^5 >
,^^> ?
$str^^@ K
,^^K L
$str^^M b
,^^b c
$"__ 
$str__ 4
{__4 5

tokenModel__5 ?
.__? @
ExpectedPickupDate__@ R
}__R S
"__S T
)__T U
;__U V
returnaa 

tokenModelaa 
;aa 
}bb 
publicdd 

asyncdd 
Taskdd 
<dd 
GasTokendd 
?dd 
>dd  
DeleteTokenAsyncdd! 1
(dd1 2
intdd2 5
iddd6 8
)dd8 9
{ee 
varff 
gasTokenModelff 
=ff 
awaitff !
_contextff" *
.ff* +
	GasTokensff+ 4
.ff4 5
FirstOrDefaultAsyncff5 H
(ffH I
xffI J
=>ffK M
xffN O
.ffO P
IdffP R
==ffS U
idffV X
)ffX Y
;ffY Z
ifhh 

(hh 
gasTokenModelhh 
==hh 
nullhh !
)hh! "
{ii 	
returnjj 
nulljj 
;jj 
}kk 	
_contextll 
.ll 
	GasTokensll 
.ll 
Removell !
(ll! "
gasTokenModelll" /
)ll/ 0
;ll0 1
awaitmm 
_contextmm 
.mm 
SaveChangesAsyncmm '
(mm' (
)mm( )
;mm) *
returnnn 
gasTokenModelnn 
;nn 
}oo 
publicqq 

asyncqq 
Taskqq 
<qq 
Listqq 
<qq 
GasTokenqq #
>qq# $
>qq$ %1
%GetGasTokensByDeliveryScheduleIdAsyncqq& K
(qqK L
intqqL O
deliveryScheduleIdqqP b
)qqb c
{rr 
returnss 
awaitss 
_contextss 
.ss 
	GasTokensss '
.ss' (
Wheress( -
(ss- .
xss. /
=>ss0 2
xss3 4
.ss4 5
DeliveryScheduleIdss5 G
==ssH J
deliveryScheduleIdssK ]
)ss] ^
.ss^ _
ToListAsyncss_ j
(ssj k
)ssk l
;ssl m
}tt 
}uu ∂6
J/Users/gayan/Developer/GasByGas/backend/Repositories/DeliveryRepository.cs
	namespace 	
backend
 
. 
Repositories 
; 
public		 
class		 
DeliveryRepository		 
:		  
IDeliveryRepository		! 4
{

 
private 
readonly  
ApplicationDbContext )
_context* 2
;2 3
public 

DeliveryRepository 
(  
ApplicationDbContext 2
context3 :
): ;
{ 
_context 
= 
context 
; 
} 
public 

async 
Task 
< 
DeliverySchedule &
>& '
CreateAsync( 3
(3 4
DeliverySchedule4 D!
deliveryScheduleModelE Z
)Z [
{ 
await 
_context 
. 
DeliverySchedules (
.( )
AddAsync) 1
(1 2!
deliveryScheduleModel2 G
)G H
;H I
await 
_context 
. 
SaveChangesAsync '
(' (
)( )
;) *
return !
deliveryScheduleModel $
;$ %
} 
	protected 
void &
AddStocksToTokenAtCreation -
(- .
). /
{ 
} 
public 

async 
Task 
< 
List 
< 
DeliverySchedule +
>+ ,
>, -
GetAllAsync. 9
(9 :
): ;
{ 
return   
await   
_context   
.   
DeliverySchedules   /
.  / 0
ToListAsync  0 ;
(  ; <
)  < =
;  = >
}!! 
public## 

async## 
Task## 
<## 
DeliverySchedule## &
?##& '
>##' (
GetById##) 0
(##0 1
int##1 4
id##5 7
)##7 8
{$$ 
return%% 
await%% 
_context%% 
.%% 
DeliverySchedules%% /
.%%/ 0
	FindAsync%%0 9
(%%9 :
id%%: <
)%%< =
;%%= >
}&& 
public)) 

async)) 
Task)) 
<)) 
bool)) 
>)) 
DeliveryExists)) *
())* +
int))+ .
id))/ 1
)))1 2
{** 
return++ 
await++ 
_context++ 
.++ 
DeliverySchedules++ /
.++/ 0
AnyAsync++0 8
(++8 9
s++9 :
=>++; =
s++> ?
.++? @
Id++@ B
==++C E
id++F H
)++H I
;++I J
},, 
public.. 

async.. 
Task.. 
<.. 
List.. 
<.. 
DeliverySchedule.. +
>..+ ,
>.., -)
GetConfirmedDeliveriesForDate... K
(..K L
DateOnly..L T
date..U Y
)..Y Z
{// 
return22 
await22 
_context22 
.22 
DeliverySchedules22 /
.33 
Where33 
(33 
d33 
=>33 
d33 
.33 
ConfirmedByAdmin33 *
&&33+ -
d33. /
.33/ 0
DeliveryDate330 <
==33= ?
date33@ D
)33D E
.44 
ToListAsync44 
(44 
)44 
;44 
}55 
public77 

async77 
Task77 
<77 
DeliverySchedule77 &
?77& '
>77' (
UpdateAsync77) 4
(774 5
int775 8
id779 ;
,77; <
DeliveryRequestDto77= O

requestDto77P Z
)77Z [
{88 
var99 !
deliveryScheduleModel99 !
=99" #
await99$ )
_context99* 2
.992 3
DeliverySchedules993 D
.99D E
	FindAsync99E N
(99N O
id99O Q
)99Q R
;99R S
if:: 

(::
 !
deliveryScheduleModel::  
==::! #
null::$ (
)::( )
return::* 0
null::1 5
;::5 6
if<< 

(<< !
deliveryScheduleModel<< !
.<<! "
DeliveryDate<<" .
!=<</ 1

requestDto<<2 <
.<<< =
DeliveryDate<<= I
)<<I J
{== 	!
deliveryScheduleModel>> !
.>>! "
DeliveryDate>>" .
=>>/ 0

requestDto>>1 ;
.>>; <
DeliveryDate>>< H
;>>H I
}@@ 	!
deliveryScheduleModelCC 
.CC 
ConfirmedByAdminCC .
=CC/ 0

requestDtoCC1 ;
.CC; <
ConfirmedByAdminCC< L
;CCL M
ifDD 

(DD !
deliveryScheduleModelDD !
.DD! "
NoOfUnitsInDeliveryDD" 5
!=DD6 8

requestDtoDD9 C
.DDC D
NoOfUnitsInDeliveryDDD W
)DDW X
{EE 	!
deliveryScheduleModelFF !
.FF! "
NoOfUnitsInDeliveryFF" 5
=FF6 7

requestDtoFF8 B
.FFB C
NoOfUnitsInDeliveryFFC V
;FFV W
}HH 	!
deliveryScheduleModelJJ 
.JJ 
OutletIdJJ &
=JJ' (

requestDtoJJ) 3
.JJ3 4
OutletIdJJ4 <
;JJ< =!
deliveryScheduleModelKK 
.KK 
DispatcherVehicleIdKK 1
=KK2 3

requestDtoKK4 >
.KK> ?
DispatcherVehicleIdKK? R
;KKR S
awaitMM 
_contextMM 
.MM 
SaveChangesAsyncMM '
(MM' (
)MM( )
;MM) *
returnNN !
deliveryScheduleModelNN $
;NN$ %
}OO 
publicQQ 

asyncQQ 
TaskQQ 
<QQ 
boolQQ 
>QQ 
DeleteAsyncQQ '
(QQ' (
intQQ( +
idQQ, .
)QQ. /
{RR 
varSS 
deliveryScheduleSS 
=SS 
awaitSS $
_contextSS% -
.SS- .
DeliverySchedulesSS. ?
.SS? @
	FindAsyncSS@ I
(SSI J
idSSJ L
)SSL M
;SSM N
ifTT 

(TT 
deliveryScheduleTT 
==TT 
nullTT  $
)TT$ %
returnTT& ,
falseTT- 2
;TT2 3
_contextVV 
.VV 
DeliverySchedulesVV "
.VV" #
RemoveVV# )
(VV) *
deliveryScheduleVV* :
)VV: ;
;VV; <
awaitWW 
_contextWW 
.WW 
SaveChangesAsyncWW '
(WW' (
)WW( )
;WW) *
returnXX 
trueXX 
;XX 
}YY 
}ZZ —
I/Users/gayan/Developer/GasByGas/backend/Repositories/AccountRepository.cs
	namespace 	
backend
 
. 
Repositories 
; 
public		 
class		 
AccountRepository		 
:		  
IAccountRepository		! 3
{

 
private 
readonly  
ApplicationDbContext )
_context* 2
;2 3
public 

AccountRepository 
(  
ApplicationDbContext 1
context2 9
)9 :
{ 
_context 
= 
context 
; 
} 
public 

async 
Task 
< 
bool 
> 

UserExists &
(& '
string' -
email. 3
)3 4
{ 
return 
await 
_context 
. 
Users #
.# $
AnyAsync$ ,
(, -
s- .
=>/ 1
s2 3
.3 4
Email4 9
==: <
email= B
)B C
;C D
} 
public 

async 
Task 
< 
List 
< 
AppUser "
>" #
># $&
GetManagersByOutletIdAsync% ?
(? @
int@ C
outletIdD L
)L M
{ 
return 
await 
_context 
. 
Users #
.# $
Where$ )
() *
s* +
=>, .
s/ 0
.0 1
OutletId1 9
==: <
outletId= E
)E F
.F G
ToListAsyncG R
(R S
)S T
;T U
} 
public 

async 
Task 
< 
List 
< 
AppUser "
>" #
># $
GetConsumersAsync% 6
(6 7
)7 8
{ 
var 
filteredUsers 
= 
await !
_context" *
.* +
Users+ 0
. 
Where 
( 
u 
=> 
u 
. 
ConsumerType &
==' )
UserType* 2
.2 3
Personal3 ;
||< >
u  !
.! "
ConsumerType" .
==/ 1
UserType2 :
.: ;
Business; C
||D F
u    !
.  ! "
ConsumerType  " .
==  / 1
UserType  2 :
.  : ;

Industries  ; E
)  E F
.!! 
ToListAsync!! 
(!! 
)!! 
;!! 
return"" 
filteredUsers"" 
;"" 
}$$ 
}%% Ãt
2/Users/gayan/Developer/GasByGas/backend/Program.cs
var 
builder 
= 
WebApplication 
. 
CreateBuilder *
(* +
args+ /
)/ 0
;0 1
builder 
. 
Services 
. 
AddControllers 
(  
)  !
.! "
AddNewtonsoftJson" 3
(3 4
options4 ;
=>< >
{ 
options 
. 
SerializerSettings 
. !
ReferenceLoopHandling 4
=5 6

Newtonsoft7 A
.A B
JsonB F
.F G!
ReferenceLoopHandlingG \
.\ ]
Ignore] c
;c d
options 
. 
SerializerSettings 
. 
NullValueHandling 0
=1 2

Newtonsoft3 =
.= >
Json> B
.B C
NullValueHandlingC T
.T U
IgnoreU [
;[ \
options 
. 
SerializerSettings 
. 
DateFormatString /
=0 1
$str2 G
;G H
options 
. 
SerializerSettings 
.  
DateTimeZoneHandling 3
=4 5

Newtonsoft6 @
.@ A
JsonA E
.E F 
DateTimeZoneHandlingF Z
.Z [
Utc[ ^
;^ _
} 
) 
; 
builder 
. 
Services 
. #
AddEndpointsApiExplorer (
(( )
)) *
;* +
builder 
. 
Services 
. 

AddOpenApi 
( 
) 
; 
builder 
. 
Services 
. 
	AddScoped 
< 
ITokenService (
,( )
TokenService* 6
>6 7
(7 8
)8 9
;9 :
builder 
. 
Services 
. 
	AddScoped 
< 
IOutletRepository ,
,, -
OutletRepository. >
>> ?
(? @
)@ A
;A B
builder   
.   
Services   
.   
	AddScoped   
<   
IKeyVaultService   +
,  + ,
KeyVaultService  - <
>  < =
(  = >
)  > ?
;  ? @
builder!! 
.!! 
Services!! 
.!! 
	AddScoped!! 
<!! 
IGasTokenRepository!! .
,!!. /
GasTokenRepository!!0 B
>!!B C
(!!C D
)!!D E
;!!E F
builder"" 
."" 
Services"" 
."" 
	AddScoped"" 
<"" 
IAccountRepository"" -
,""- .
AccountRepository""/ @
>""@ A
(""A B
)""B C
;""C D
builder## 
.## 
Services## 
.## 
	AddScoped## 
<## 
IDeliveryRepository## .
,##. /
DeliveryRepository##0 B
>##B C
(##C D
)##D E
;##E F
builder$$ 
.$$ 
Services$$ 
.$$ 
	AddScoped$$ 
<$$ 
ISmsService$$ &
,$$& '

SmsService$$( 2
>$$2 3
($$3 4
)$$4 5
;$$5 6
builder%% 
.%% 
Services%% 
.%% 
	AddScoped%% 
<%% 
IMailService%% '
,%%' (
MailService%%) 4
>%%4 5
(%%5 6
)%%6 7
;%%7 8
builder&& 
.&& 
Services&& 
.&& 
	AddScoped&& 
<&& 
IStockRepository&& +
,&&+ ,
StockRepository&&- <
>&&< =
(&&= >
)&&> ?
;&&? @
builder(( 
.(( 
Services(( 
.(( 
AddSingleton(( 
<(( 
SchedulerService(( .
>((. /
(((/ 0
)((0 1
;((1 2
builder)) 
.)) 
Services)) 
.)) 
AddSingleton)) 
<)) 
IKeyVaultService)) .
,)). /
KeyVaultService))0 ?
>))? @
())@ A
)))A B
;))B C
builder++ 
.++ 
Services++ 
.++ 
AddHostedService++ !
<++! "
SchedulerService++" 2
>++2 3
(++3 4
)++4 5
;++5 6
builder.. 
... 
Services.. 
... 
AddCors.. 
(.. 
options..  
=>..! #
{// 
options00 
.00 
	AddPolicy00 
(00 
$str00 ,
,00, -
policy11 
=>11 
policy11 
.11 
WithOrigins11 $
(11$ %
$str11% <
,11< =
$str11= T
,11T U
$str	11V é
)
11é è
.22 
AllowAnyHeader22 
(22 
)22 
.33 
AllowAnyMethod33 
(33 
)33 
)33 
;33 
}44 
)44 
;44 
builder66 
.66 
Services66 
.66 
AddSwaggerGen66 
(66 
option66 %
=>66& (
{77 
option99 

.99
 

SwaggerDoc99 
(99 
$str99 
,99 
new99 
OpenApiInfo99  +
{99, -
Title99. 3
=994 5
$str996 F
,99F G
Version99H O
=99P Q
$str99R V
}99W X
)99X Y
;99Y Z
option:: 

.::
 
SchemaFilter:: 
<:: 
EnumSchemaFilter:: (
>::( )
(::) *
)::* +
;::+ ,
option<< 

.<<
 !
AddSecurityDefinition<<  
(<<  !
$str<<! )
,<<) *
new<<+ .!
OpenApiSecurityScheme<</ D
{== 
In>> 

=>> 
ParameterLocation>> 
.>> 
Header>> %
,>>% &
Description?? 
=?? 
$str?? 2
,??2 3
Name@@ 
=@@ 
$str@@ 
,@@ 
TypeAA 
=AA 
SecuritySchemeTypeAA !
.AA! "
HttpAA" &
,AA& '
BearerFormatBB 
=BB 
$strBB 
,BB 
SchemeCC 
=CC 
$strCC 
}DD 
)DD 
;DD 
optionEE 

.EE
 "
AddSecurityRequirementEE !
(EE! "
newEE" %&
OpenApiSecurityRequirementEE& @
{FF 
{GG 	
newHH !
OpenApiSecuritySchemeHH %
{II 
	ReferenceJJ 
=JJ 
newJJ 
OpenApiReferenceJJ  0
{KK 
TypeLL 
=LL 
ReferenceTypeLL &
.LL& '
SecuritySchemeLL' 5
,LL5 6
IdMM 
=MM 
$strMM 
}NN 
}OO 
,OO 
[PP 
]PP 
}QQ 	
}RR 
)RR 
;RR 
}SS 
)SS 
;SS 
builderUU 
.UU 
ServicesUU 
.UU 
AddDbContextUU 
<UU  
ApplicationDbContextUU 2
>UU2 3
(UU3 4
optionsUU4 ;
=>UU< >
{VV 
optionsWW 
.WW 
UseSqlServerWW 
(WW 
builderWW  
.WW  !
ConfigurationWW! .
.WW. /
GetConnectionStringWW/ B
(WWB C
$strWWC V
)WWV W
)WWW X
;WWX Y
}XX 
)XX 
;XX 
varZZ 
keyVaultUriZZ 
=ZZ 
builderZZ 
.ZZ 
ConfigurationZZ '
[ZZ' (
$strZZ( @
]ZZ@ A
;ZZA B
if[[ 
([[ 
![[ 
string[[ 
.[[ 
IsNullOrEmpty[[ 
([[ 
keyVaultUri[[ %
)[[% &
)[[& '
{\\ 
builder]] 
.]] 
Configuration]] 
.]] 
AddAzureKeyVault]] *
(]]* +
new^^ 
Uri^^ 
(^^ 
keyVaultUri^^ 
)^^ 
,^^ 
new__ "
DefaultAzureCredential__ "
(__" #
)__# $
)__$ %
;__% &
}`` 
varaa 

signingKeyaa 
=aa 
builderaa 
.aa 
Configurationaa &
[aa& '
$straa' 6
]aa6 7
;aa7 8
buildercc 
.cc 
Servicescc 
.cc 
AddIdentitycc 
<cc 
AppUsercc $
,cc$ %
IdentityRolecc& 2
>cc2 3
(cc3 4
optionscc4 ;
=>cc< >
{dd 
optionsee 
.ee 
Passwordee 
.ee 
RequireDigitee !
=ee" #
falseee$ )
;ee) *
optionsff 
.ff 
Passwordff 
.ff 
RequireLowercaseff %
=ff& '
falseff( -
;ff- .
optionsgg 
.gg 
Passwordgg 
.gg "
RequireNonAlphanumericgg +
=gg, -
falsegg. 3
;gg3 4
optionshh 
.hh 
Passwordhh 
.hh 
RequireUppercasehh %
=hh& '
falsehh( -
;hh- .
optionsii 
.ii 
Passwordii 
.ii 
RequiredLengthii #
=ii$ %
$numii& '
;ii' (
optionskk 
.kk 
SignInkk 
.kk !
RequireConfirmedEmailkk (
=kk) *
falsekk+ 0
;kk0 1
optionsll 
.ll 
SignInll 
.ll '
RequireConfirmedPhoneNumberll .
=ll/ 0
falsell1 6
;ll6 7
optionsmm 
.mm 
Usermm 
.mm 
RequireUniqueEmailmm #
=mm$ %
truemm& *
;mm* +
}nn 
)nn 
.nn $
AddEntityFrameworkStoresnn 
<nn  
ApplicationDbContextnn 0
>nn0 1
(nn1 2
)nn2 3
;nn3 4
builderpp 
.pp 
Servicespp 
.pp 
AddAuthenticationpp "
(pp" #
optionspp# *
=>pp+ -
{qq 
optionsrr 
.rr %
DefaultAuthenticateSchemerr %
=rr& '
optionsss 
.ss "
DefaultChallengeSchemess &
=ss' (
optionstt 
.tt 
DefaultForbidSchemett '
=tt( )
optionsuu 
.uu 
DefaultSchemeuu %
=uu& '
optionsvv 
.vv 
DefaultSignInSchemevv /
=vv0 1
optionsww 
.ww   
DefaultSignOutSchemeww  4
=ww5 6
JwtBearerDefaultsww7 H
.wwH I 
AuthenticationSchemewwI ]
;ww] ^
}xx 
)xx 
.xx 
AddJwtBearerxx 
(xx 
optionsxx 
=>xx 
{yy 
optionszz 
.zz %
TokenValidationParameterszz %
=zz& '
newzz( +%
TokenValidationParameterszz, E
{{{ 
ValidateIssuer|| 
=|| 
true|| 
,|| 
ValidIssuer}} 
=}} 
builder}} 
.}} 
Configuration}} +
[}}+ ,
$str}}, 8
]}}8 9
,}}9 :
ValidAudience~~ 
=~~ 
builder~~ 
.~~  
Configuration~~  -
[~~- .
$str~~. <
]~~< =
,~~= >$
ValidateIssuerSigningKey  
=! "
true# '
,' (
IssuerSigningKey
ÄÄ 
=
ÄÄ 
new
ÄÄ "
SymmetricSecurityKey
ÄÄ 3
(
ÄÄ3 4
System
ÅÅ 
.
ÅÅ 
Text
ÅÅ 
.
ÅÅ 
Encoding
ÅÅ  
.
ÅÅ  !
UTF8
ÅÅ! %
.
ÅÅ% &
GetBytes
ÅÅ& .
(
ÅÅ. /

signingKey
ÅÅ/ 9
??
ÅÅ: <
throw
ÅÅ= B
new
ÅÅC F'
InvalidOperationException
ÅÅG `
(
ÅÅ` a
)
ÅÅa b
)
ÅÅb c
)
ÅÅc d
}
ÇÇ 
;
ÇÇ 
}ÉÉ 
)
ÉÉ 
;
ÉÉ 
varââ 
app
ââ 
=
ââ 	
builder
ââ
 
.
ââ 
Build
ââ 
(
ââ 
)
ââ 
;
ââ 
varåå 
keyVaultService
åå 
=
åå 
app
åå 
.
åå 
Services
åå "
.
åå" # 
GetRequiredService
åå# 5
<
åå5 6
IKeyVaultService
åå6 F
>
ååF G
(
ååG H
)
ååH I
;
ååI J
varçç  
dbConnectionString
çç 
=
çç 
await
çç 
keyVaultService
çç .
.
çç. /
GetSecretAsync
çç/ =
(
çç= >
$str
çç> R
)
ççR S
;
ççS T
ifíí 
(
íí 
app
íí 
.
íí 
Environment
íí 
.
íí 
IsDevelopment
íí !
(
íí! "
)
íí" #
||
íí$ &
app
íí' *
.
íí* +
Environment
íí+ 6
.
íí6 7
IsProduction
íí7 C
(
ííC D
)
ííD E
||
ííF H
app
ííI L
.
ííL M
Environment
ííM X
.
ííX Y
	IsStaging
ííY b
(
ííb c
)
ííc d
)
ííd e
{ìì 
app
ïï 
.
ïï 

UseSwagger
ïï 
(
ïï 
)
ïï 
;
ïï 
app
ññ 
.
ññ 
UseSwaggerUI
ññ 
(
ññ 
options
ññ 
=>
ññ 
{
óó 
}
ôô 
)
ôô 
;
ôô 
}¶¶ 
app®® 
.
®® !
UseHttpsRedirection
®® 
(
®® 
)
®® 
;
®® 
app©© 
.
©© 
UseAuthentication
©© 
(
©© 
)
©© 
;
©© 
app™™ 
.
™™ 
UseAuthorization
™™ 
(
™™ 
)
™™ 
;
™™ 
app≠≠ 
.
≠≠ 
UseCors
≠≠ 
(
≠≠ 
$str
≠≠ "
)
≠≠" #
;
≠≠# $
appÆÆ 
.
ÆÆ 
MapControllers
ÆÆ 
(
ÆÆ 
)
ÆÆ 
;
ÆÆ 
app∞∞ 
.
∞∞ 
Run
∞∞ 
(
∞∞ 
)
∞∞ 	
;
∞∞	 
ï
>/Users/gayan/Developer/GasByGas/backend/Models/StockRequest.cs
	namespace 	
backend
 
. 
Models 
; 
public 
class 
StockRequest 
{ 
[ 
Key 
] 	
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public

 

required

 
int

 
OutletId

  
{

! "
get

# &
;

& '
set

( +
;

+ ,
}

- .
public 

required 
DateOnly 
RequestedDate *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
public 

DateOnly 
? 
CompletedDate "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 

bool 
	Completed 
{ 
get 
;  
set! $
;$ %
}& '
=( )
false* /
;/ 0
public 

int 
? 
DeliveryScheduleId "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 

int 
NoOfUnitsRequired  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

int 
NoOfUnitsDispatched "
{# $
get% (
;( )
set* -
;- .
}/ 0
} ¡
8/Users/gayan/Developer/GasByGas/backend/Models/Outlet.cs
	namespace 	
backend
 
. 
Models 
; 
public 
class 
Outlet 
{ 
[ 
Key 
] 	
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
[

 
	MaxLength

 
(

 
$num

 
)

 
]

 
public 

required 
string 

OutletName %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
[ 
	MaxLength 
( 
$num 
) 
] 
public 

string 
? 
OutletAddress  
{! "
get# &
;& '
set( +
;+ ,
}- .
[ 
	MaxLength 
( 
$num 
) 
] 
public 

required 
string 
City 
{  !
get" %
;% &
set' *
;* +
}, -
public 

int 
? 
Stock 
{ 
get 
; 
set  
;  !
}" #
=$ %
$num& '
;' (
} ‡
:/Users/gayan/Developer/GasByGas/backend/Models/GasToken.cs
	namespace 	
backend
 
. 
Models 
; 
public 
class 
GasToken 
{ 
[		 
Key		 
]		 	
public

 

int

 
Id

 
{

 
get

 
;

 
set

 
;

 
}

 
[ 
DataType 
( 
DataType 
. 
Date 
) 
] 
public 

required 
DateOnly 
RequestDate (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
=7 8
DateOnly9 A
.A B
FromDateTimeB N
(N O
DateTimeO W
.W X
NowX [
)[ \
;\ ]
[ 
DataType 
( 
DataType 
. 
Date 
) 
] 
public 

DateOnly 
? 
	ReadyDate 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 
DataType 
( 
DataType 
. 
Date 
) 
] 
public 

required 
DateOnly 
ExpectedPickupDate /
{0 1
get2 5
;5 6
set7 :
;: ;
}< =
public 

required 
GasTokenStatus "
Status# )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
=8 9
GasTokenStatus: H
.H I
PendingI P
;P Q
public 

required 
UserType 
UserType %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
public 

bool  
IsEmptyCylinderGiven $
{% &
get' *
;* +
set, /
;/ 0
}1 2
=3 4
false5 :
;: ;
[ 
	Precision 
( 
$num 
, 
$num 
) 
] 
public 

decimal 
? 
Price 
{ 
get 
;  
set! $
;$ %
}& '
public 

bool 
IsPaid 
{ 
get 
; 
set !
;! "
}# $
=% &
false' ,
;, -
public   

DateOnly   
?   
PaymentDate    
{  ! "
get  # &
;  & '
set  ( +
;  + ,
}  - .
["" 
	MaxLength"" 
("" 
$num"" 
)"" 
]"" 
public## 

required## 
string## 
	UserEmail## $
{##% &
get##' *
;##* +
set##, /
;##/ 0
}##1 2
public%% 

required%% 
int%% 
OutletId%%  
{%%! "
get%%# &
;%%& '
set%%( +
;%%+ ,
}%%- .
public'' 

int'' 
?'' 
DeliveryScheduleId'' "
{''# $
get''% (
;''( )
set''* -
;''- .
}''/ 0
},, Î
B/Users/gayan/Developer/GasByGas/backend/Models/DeliverySchedule.cs
	namespace 	
backend
 
. 
Models 
; 
public 
class 
DeliverySchedule 
{ 
[ 
Key 
] 	
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public		 

required		 
DateOnly		 
DeliveryDate		 )
{		* +
get		, /
;		/ 0
set		1 4
;		4 5
}		6 7
public

 

required

 
bool

 
ConfirmedByAdmin

 )
{

* +
get

, /
;

/ 0
set

1 4
;

4 5
}

6 7
=

8 9
false

: ?
;

? @
public 

required 
int 
NoOfUnitsInDelivery +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
public 

required 
int 
OutletId  
{! "
get# &
;& '
set( +
;+ ,
}- .
[ 
	MaxLength 
( 
$num 
) 
] 
public 

required 
string 
DispatcherVehicleId .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
} «
9/Users/gayan/Developer/GasByGas/backend/Models/AppUser.cs
	namespace 	
backend
 
. 
Models 
; 
public 
class 
AppUser 
: 
IdentityUser #
{ 
[		 
	MaxLength		 
(		 
$num		 
)		 
]		 
public

 

string

 
?

 
FullName

 
{

 
get

 !
;

! "
set

# &
;

& '
}

( )
[ 
	MaxLength 
( 
$num 
) 
] 
public 

string 
? 
Nic 
{ 
get 
; 
set !
;! "
}# $
[ 
	MaxLength 
( 
$num 
) 
] 
public 

string 
?  
BusinessRegistration '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
public 

bool 
	IsConfirm 
{ 
get 
;  
set! $
;$ %
}& '
[ 
	MaxLength 
( 
$num 
) 
] 
public 

string 
? 
Address 
{ 
get  
;  !
set" %
;% &
}' (
[ 
	MaxLength 
( 
$num 
) 
] 
public 

string 
? 
City 
{ 
get 
; 
set "
;" #
}$ %
public 

UserType 
? 
ConsumerType !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 

int 
? 
OutletId 
{ 
get 
; 
set  #
;# $
}% &
public!! 

int!! 
?!!  
NoOfCylindersAllowed!! $
{!!% &
get!!' *
;!!* +
set!!, /
;!!/ 0
}!!1 2
public## 

int## 
?## %
RemainingCylindersAllowed## )
{##* +
get##, /
;##/ 0
set##1 4
;##4 5
}##6 7
}%% ò)
M/Users/gayan/Developer/GasByGas/backend/Migrations/20250308175951_NICtoNic.cs
	namespace 	
backend
 
. 

Migrations 
{ 
public

 

partial

 
class

 
NICtoNic

 !
:

" #
	Migration

$ -
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 
RenameColumn )
() *
name 
: 
$str 
, 
table   
:   
$str   $
,  $ %
newName!! 
:!! 
$str!! 
)!! 
;!!  
migrationBuilder## 
.## 

InsertData## '
(##' (
table$$ 
:$$ 
$str$$ $
,$$$ %
columns%% 
:%% 
new%% 
[%% 
]%% 
{%%  
$str%%! %
,%%% &
$str%%' 9
,%%9 :
$str%%; A
,%%A B
$str%%C S
}%%T U
,%%U V
values&& 
:&& 
new&& 
object&& "
[&&" #
,&&# $
]&&$ %
{'' 
{(( 
$str(( <
,((< =
null((> B
,((B C
$str((D M
,((M N
$str((O X
}((Y Z
,((Z [
{)) 
$str)) <
,))< =
null))> B
,))B C
$str))D K
,))K L
$str))M T
}))U V
,))V W
{** 
$str** <
,**< =
null**> B
,**B C
$str**D J
,**J K
$str**L R
}**S T
}++ 
)++ 
;++ 
},, 	
	protected// 
override// 
void// 
Down//  $
(//$ %
MigrationBuilder//% 5
migrationBuilder//6 F
)//F G
{00 	
migrationBuilder11 
.11 

DeleteData11 '
(11' (
table22 
:22 
$str22 $
,22$ %
	keyColumn33 
:33 
$str33 
,33  
keyValue44 
:44 
$str44 @
)44@ A
;44A B
migrationBuilder66 
.66 

DeleteData66 '
(66' (
table77 
:77 
$str77 $
,77$ %
	keyColumn88 
:88 
$str88 
,88  
keyValue99 
:99 
$str99 @
)99@ A
;99A B
migrationBuilder;; 
.;; 

DeleteData;; '
(;;' (
table<< 
:<< 
$str<< $
,<<$ %
	keyColumn== 
:== 
$str== 
,==  
keyValue>> 
:>> 
$str>> @
)>>@ A
;>>A B
migrationBuilder@@ 
.@@ 
RenameColumn@@ )
(@@) *
nameAA 
:AA 
$strAA 
,AA 
tableBB 
:BB 
$strBB $
,BB$ %
newNameCC 
:CC 
$strCC 
)CC 
;CC  
migrationBuilderEE 
.EE 

InsertDataEE '
(EE' (
tableFF 
:FF 
$strFF $
,FF$ %
columnsGG 
:GG 
newGG 
[GG 
]GG 
{GG  
$strGG! %
,GG% &
$strGG' 9
,GG9 :
$strGG; A
,GGA B
$strGGC S
}GGT U
,GGU V
valuesHH 
:HH 
newHH 
objectHH "
[HH" #
,HH# $
]HH$ %
{II 
{JJ 
$strJJ <
,JJ< =
nullJJ> B
,JJB C
$strJJD K
,JJK L
$strJJM T
}JJU V
,JJV W
{KK 
$strKK <
,KK< =
nullKK> B
,KKB C
$strKKD M
,KKM N
$strKKO X
}KKY Z
,KKZ [
{LL 
$strLL <
,LL< =
nullLL> B
,LLB C
$strLLD J
,LLJ K
$strLLL R
}LLS T
}MM 
)MM 
;MM 
}NN 	
}OO 
}PP ™)
V/Users/gayan/Developer/GasByGas/backend/Migrations/20250308170938_UpdatedTokenTable.cs
	namespace 	
backend
 
. 

Migrations 
{ 
public

 

partial

 
class

 
UpdatedTokenTable

 *
:

+ ,
	Migration

- 6
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 
RenameColumn )
() *
name 
: 
$str /
,/ 0
table   
:   
$str   "
,  " #
newName!! 
:!! 
$str!! /
)!!/ 0
;!!0 1
migrationBuilder## 
.## 

InsertData## '
(##' (
table$$ 
:$$ 
$str$$ $
,$$$ %
columns%% 
:%% 
new%% 
[%% 
]%% 
{%%  
$str%%! %
,%%% &
$str%%' 9
,%%9 :
$str%%; A
,%%A B
$str%%C S
}%%T U
,%%U V
values&& 
:&& 
new&& 
object&& "
[&&" #
,&&# $
]&&$ %
{'' 
{(( 
$str(( <
,((< =
null((> B
,((B C
$str((D K
,((K L
$str((M T
}((U V
,((V W
{)) 
$str)) <
,))< =
null))> B
,))B C
$str))D M
,))M N
$str))O X
}))Y Z
,))Z [
{** 
$str** <
,**< =
null**> B
,**B C
$str**D J
,**J K
$str**L R
}**S T
}++ 
)++ 
;++ 
},, 	
	protected// 
override// 
void// 
Down//  $
(//$ %
MigrationBuilder//% 5
migrationBuilder//6 F
)//F G
{00 	
migrationBuilder11 
.11 

DeleteData11 '
(11' (
table22 
:22 
$str22 $
,22$ %
	keyColumn33 
:33 
$str33 
,33  
keyValue44 
:44 
$str44 @
)44@ A
;44A B
migrationBuilder66 
.66 

DeleteData66 '
(66' (
table77 
:77 
$str77 $
,77$ %
	keyColumn88 
:88 
$str88 
,88  
keyValue99 
:99 
$str99 @
)99@ A
;99A B
migrationBuilder;; 
.;; 

DeleteData;; '
(;;' (
table<< 
:<< 
$str<< $
,<<$ %
	keyColumn== 
:== 
$str== 
,==  
keyValue>> 
:>> 
$str>> @
)>>@ A
;>>A B
migrationBuilder@@ 
.@@ 
RenameColumn@@ )
(@@) *
nameAA 
:AA 
$strAA ,
,AA, -
tableBB 
:BB 
$strBB "
,BB" #
newNameCC 
:CC 
$strCC 2
)CC2 3
;CC3 4
migrationBuilderEE 
.EE 

InsertDataEE '
(EE' (
tableFF 
:FF 
$strFF $
,FF$ %
columnsGG 
:GG 
newGG 
[GG 
]GG 
{GG  
$strGG! %
,GG% &
$strGG' 9
,GG9 :
$strGG; A
,GGA B
$strGGC S
}GGT U
,GGU V
valuesHH 
:HH 
newHH 
objectHH "
[HH" #
,HH# $
]HH$ %
{II 
{JJ 
$strJJ <
,JJ< =
nullJJ> B
,JJB C
$strJJD M
,JJM N
$strJJO X
}JJY Z
,JJZ [
{KK 
$strKK <
,KK< =
nullKK> B
,KKB C
$strKKD K
,KKK L
$strKKM T
}KKU V
,KKV W
{LL 
$strLL <
,LL< =
nullLL> B
,LLB C
$strLLD J
,LLJ K
$strLLL R
}LLS T
}MM 
)MM 
;MM 
}NN 	
}OO 
}PP ƒ0
\/Users/gayan/Developer/GasByGas/backend/Migrations/20250308162621_UpdatedDeliverySchedule.cs
	namespace 	
backend
 
. 

Migrations 
{ 
public

 

partial

 
class

 #
UpdatedDeliverySchedule

 0
:

1 2
	Migration

3 <
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DropColumn '
(' (
name 
: 
$str $
,$ %
table   
:   
$str   *
)  * +
;  + ,
migrationBuilder"" 
."" 
	AddColumn"" &
<""& '
string""' -
>""- .
("". /
name## 
:## 
$str## +
,##+ ,
table$$ 
:$$ 
$str$$ *
,$$* +
type%% 
:%% 
$str%% $
,%%$ %
	maxLength&& 
:&& 
$num&& 
,&& 
nullable'' 
:'' 
false'' 
,''  
defaultValue(( 
:(( 
$str((  
)((  !
;((! "
migrationBuilder** 
.** 

InsertData** '
(**' (
table++ 
:++ 
$str++ $
,++$ %
columns,, 
:,, 
new,, 
[,, 
],, 
{,,  
$str,,! %
,,,% &
$str,,' 9
,,,9 :
$str,,; A
,,,A B
$str,,C S
},,T U
,,,U V
values-- 
:-- 
new-- 
object-- "
[--" #
,--# $
]--$ %
{.. 
{// 
$str// <
,//< =
null//> B
,//B C
$str//D M
,//M N
$str//O X
}//Y Z
,//Z [
{00 
$str00 <
,00< =
null00> B
,00B C
$str00D K
,00K L
$str00M T
}00U V
,00V W
{11 
$str11 <
,11< =
null11> B
,11B C
$str11D J
,11J K
$str11L R
}11S T
}22 
)22 
;22 
}33 	
	protected66 
override66 
void66 
Down66  $
(66$ %
MigrationBuilder66% 5
migrationBuilder666 F
)66F G
{77 	
migrationBuilder88 
.88 

DeleteData88 '
(88' (
table99 
:99 
$str99 $
,99$ %
	keyColumn:: 
::: 
$str:: 
,::  
keyValue;; 
:;; 
$str;; @
);;@ A
;;;A B
migrationBuilder== 
.== 

DeleteData== '
(==' (
table>> 
:>> 
$str>> $
,>>$ %
	keyColumn?? 
:?? 
$str?? 
,??  
keyValue@@ 
:@@ 
$str@@ @
)@@@ A
;@@A B
migrationBuilderBB 
.BB 

DeleteDataBB '
(BB' (
tableCC 
:CC 
$strCC $
,CC$ %
	keyColumnDD 
:DD 
$strDD 
,DD  
keyValueEE 
:EE 
$strEE @
)EE@ A
;EEA B
migrationBuilderGG 
.GG 

DropColumnGG '
(GG' (
nameHH 
:HH 
$strHH +
,HH+ ,
tableII 
:II 
$strII *
)II* +
;II+ ,
migrationBuilderKK 
.KK 
	AddColumnKK &
<KK& '
intKK' *
>KK* +
(KK+ ,
nameLL 
:LL 
$strLL $
,LL$ %
tableMM 
:MM 
$strMM *
,MM* +
typeNN 
:NN 
$strNN 
,NN 
nullableOO 
:OO 
falseOO 
,OO  
defaultValuePP 
:PP 
$numPP 
)PP  
;PP  !
migrationBuilderRR 
.RR 

InsertDataRR '
(RR' (
tableSS 
:SS 
$strSS $
,SS$ %
columnsTT 
:TT 
newTT 
[TT 
]TT 
{TT  
$strTT! %
,TT% &
$strTT' 9
,TT9 :
$strTT; A
,TTA B
$strTTC S
}TTT U
,TTU V
valuesUU 
:UU 
newUU 
objectUU "
[UU" #
,UU# $
]UU$ %
{VV 
{WW 
$strWW <
,WW< =
nullWW> B
,WWB C
$strWWD M
,WWM N
$strWWO X
}WWY Z
,WWZ [
{XX 
$strXX <
,XX< =
nullXX> B
,XXB C
$strXXD J
,XXJ K
$strXXL R
}XXS T
,XXT U
{YY 
$strYY <
,YY< =
nullYY> B
,YYB C
$strYYD K
,YYK L
$strYYM T
}YYU V
}ZZ 
)ZZ 
;ZZ 
}[[ 	
}\\ 
}]] /
W/Users/gayan/Developer/GasByGas/backend/Migrations/20250308155557_UpdatetoStockTable.cs
	namespace 	
backend
 
. 

Migrations 
{ 
public

 

partial

 
class

 
UpdatetoStockTable

 +
:

, -
	Migration

. 7
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 
	AddColumn &
<& '
int' *
>* +
(+ ,
name 
: 
$str +
,+ ,
table   
:   
$str   &
,  & '
type!! 
:!! 
$str!! 
,!! 
nullable"" 
:"" 
false"" 
,""  
defaultValue## 
:## 
$num## 
)##  
;##  !
migrationBuilder%% 
.%% 
	AddColumn%% &
<%%& '
int%%' *
>%%* +
(%%+ ,
name&& 
:&& 
$str&& )
,&&) *
table'' 
:'' 
$str'' &
,''& '
type(( 
:(( 
$str(( 
,(( 
nullable)) 
:)) 
false)) 
,))  
defaultValue** 
:** 
$num** 
)**  
;**  !
migrationBuilder,, 
.,, 

InsertData,, '
(,,' (
table-- 
:-- 
$str-- $
,--$ %
columns.. 
:.. 
new.. 
[.. 
].. 
{..  
$str..! %
,..% &
$str..' 9
,..9 :
$str..; A
,..A B
$str..C S
}..T U
,..U V
values// 
:// 
new// 
object// "
[//" #
,//# $
]//$ %
{00 
{11 
$str11 <
,11< =
null11> B
,11B C
$str11D M
,11M N
$str11O X
}11Y Z
,11Z [
{22 
$str22 <
,22< =
null22> B
,22B C
$str22D J
,22J K
$str22L R
}22S T
,22T U
{33 
$str33 <
,33< =
null33> B
,33B C
$str33D K
,33K L
$str33M T
}33U V
}44 
)44 
;44 
}55 	
	protected88 
override88 
void88 
Down88  $
(88$ %
MigrationBuilder88% 5
migrationBuilder886 F
)88F G
{99 	
migrationBuilder:: 
.:: 

DeleteData:: '
(::' (
table;; 
:;; 
$str;; $
,;;$ %
	keyColumn<< 
:<< 
$str<< 
,<<  
keyValue== 
:== 
$str== @
)==@ A
;==A B
migrationBuilder?? 
.?? 

DeleteData?? '
(??' (
table@@ 
:@@ 
$str@@ $
,@@$ %
	keyColumnAA 
:AA 
$strAA 
,AA  
keyValueBB 
:BB 
$strBB @
)BB@ A
;BBA B
migrationBuilderDD 
.DD 

DeleteDataDD '
(DD' (
tableEE 
:EE 
$strEE $
,EE$ %
	keyColumnFF 
:FF 
$strFF 
,FF  
keyValueGG 
:GG 
$strGG @
)GG@ A
;GGA B
migrationBuilderII 
.II 

DropColumnII '
(II' (
nameJJ 
:JJ 
$strJJ +
,JJ+ ,
tableKK 
:KK 
$strKK &
)KK& '
;KK' (
migrationBuilderMM 
.MM 

DropColumnMM '
(MM' (
nameNN 
:NN 
$strNN )
,NN) *
tableOO 
:OO 
$strOO &
)OO& '
;OO' (
migrationBuilderQQ 
.QQ 

InsertDataQQ '
(QQ' (
tableRR 
:RR 
$strRR $
,RR$ %
columnsSS 
:SS 
newSS 
[SS 
]SS 
{SS  
$strSS! %
,SS% &
$strSS' 9
,SS9 :
$strSS; A
,SSA B
$strSSC S
}SST U
,SSU V
valuesTT 
:TT 
newTT 
objectTT "
[TT" #
,TT# $
]TT$ %
{UU 
{VV 
$strVV <
,VV< =
nullVV> B
,VVB C
$strVVD M
,VVM N
$strVVO X
}VVY Z
,VVZ [
{WW 
$strWW <
,WW< =
nullWW> B
,WWB C
$strWWD J
,WWJ K
$strWWL R
}WWS T
,WWT U
{XX 
$strXX <
,XX< =
nullXX> B
,XXB C
$strXXD K
,XXK L
$strXXM T
}XXU V
}YY 
)YY 
;YY 
}ZZ 	
}[[ 
}\\ ç:
U/Users/gayan/Developer/GasByGas/backend/Migrations/20250308143719_StockEntityAdded.cs
	namespace 	
backend
 
. 

Migrations 
{		 
public 

partial 
class 
StockEntityAdded )
:* +
	Migration, 5
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 
CreateTable (
(( )
name   
:   
$str   %
,  % &
columns!! 
:!! 
table!! 
=>!! !
new!!" %
{"" 
Id## 
=## 
table## 
.## 
Column## %
<##% &
int##& )
>##) *
(##* +
type##+ /
:##/ 0
$str##1 6
,##6 7
nullable##8 @
:##@ A
false##B G
)##G H
.$$ 

Annotation$$ #
($$# $
$str$$$ 8
,$$8 9
$str$$: @
)$$@ A
,$$A B
OutletId%% 
=%% 
table%% $
.%%$ %
Column%%% +
<%%+ ,
int%%, /
>%%/ 0
(%%0 1
type%%1 5
:%%5 6
$str%%7 <
,%%< =
nullable%%> F
:%%F G
false%%H M
)%%M N
,%%N O
RequestedDate&& !
=&&" #
table&&$ )
.&&) *
Column&&* 0
<&&0 1
DateOnly&&1 9
>&&9 :
(&&: ;
type&&; ?
:&&? @
$str&&A G
,&&G H
nullable&&I Q
:&&Q R
false&&S X
)&&X Y
,&&Y Z
CompletedDate'' !
=''" #
table''$ )
.'') *
Column''* 0
<''0 1
DateOnly''1 9
>''9 :
('': ;
type''; ?
:''? @
$str''A G
,''G H
nullable''I Q
:''Q R
true''S W
)''W X
,''X Y
	Completed(( 
=(( 
table((  %
.((% &
Column((& ,
<((, -
bool((- 1
>((1 2
(((2 3
type((3 7
:((7 8
$str((9 >
,((> ?
nullable((@ H
:((H I
false((J O
)((O P
,((P Q
DeliveryScheduleId)) &
=))' (
table))) .
.)). /
Column))/ 5
<))5 6
int))6 9
>))9 :
()): ;
type)); ?
:))? @
$str))A F
,))F G
nullable))H P
:))P Q
true))R V
)))V W
}** 
,** 
constraints++ 
:++ 
table++ "
=>++# %
{,, 
table-- 
.-- 

PrimaryKey-- $
(--$ %
$str--% 7
,--7 8
x--9 :
=>--; =
x--> ?
.--? @
Id--@ B
)--B C
;--C D
}.. 
).. 
;.. 
migrationBuilder00 
.00 

InsertData00 '
(00' (
table11 
:11 
$str11 $
,11$ %
columns22 
:22 
new22 
[22 
]22 
{22  
$str22! %
,22% &
$str22' 9
,229 :
$str22; A
,22A B
$str22C S
}22T U
,22U V
values33 
:33 
new33 
object33 "
[33" #
,33# $
]33$ %
{44 
{55 
$str55 <
,55< =
null55> B
,55B C
$str55D M
,55M N
$str55O X
}55Y Z
,55Z [
{66 
$str66 <
,66< =
null66> B
,66B C
$str66D J
,66J K
$str66L R
}66S T
,66T U
{77 
$str77 <
,77< =
null77> B
,77B C
$str77D K
,77K L
$str77M T
}77U V
}88 
)88 
;88 
}99 	
	protected<< 
override<< 
void<< 
Down<<  $
(<<$ %
MigrationBuilder<<% 5
migrationBuilder<<6 F
)<<F G
{== 	
migrationBuilder>> 
.>> 
	DropTable>> &
(>>& '
name?? 
:?? 
$str?? %
)??% &
;??& '
migrationBuilderAA 
.AA 

DeleteDataAA '
(AA' (
tableBB 
:BB 
$strBB $
,BB$ %
	keyColumnCC 
:CC 
$strCC 
,CC  
keyValueDD 
:DD 
$strDD @
)DD@ A
;DDA B
migrationBuilderFF 
.FF 

DeleteDataFF '
(FF' (
tableGG 
:GG 
$strGG $
,GG$ %
	keyColumnHH 
:HH 
$strHH 
,HH  
keyValueII 
:II 
$strII @
)II@ A
;IIA B
migrationBuilderKK 
.KK 

DeleteDataKK '
(KK' (
tableLL 
:LL 
$strLL $
,LL$ %
	keyColumnMM 
:MM 
$strMM 
,MM  
keyValueNN 
:NN 
$strNN @
)NN@ A
;NNA B
migrationBuilderPP 
.PP 

InsertDataPP '
(PP' (
tableQQ 
:QQ 
$strQQ $
,QQ$ %
columnsRR 
:RR 
newRR 
[RR 
]RR 
{RR  
$strRR! %
,RR% &
$strRR' 9
,RR9 :
$strRR; A
,RRA B
$strRRC S
}RRT U
,RRU V
valuesSS 
:SS 
newSS 
objectSS "
[SS" #
,SS# $
]SS$ %
{TT 
{UU 
$strUU <
,UU< =
nullUU> B
,UUB C
$strUUD K
,UUK L
$strUUM T
}UUU V
,UUV W
{VV 
$strVV <
,VV< =
nullVV> B
,VVB C
$strVVD J
,VVJ K
$strVVL R
}VVS T
,VVT U
{WW 
$strWW <
,WW< =
nullWW> B
,WWB C
$strWWD M
,WWM N
$strWWO X
}WWY Z
}XX 
)XX 
;XX 
}YY 	
}ZZ 
}[[ Ë.
^/Users/gayan/Developer/GasByGas/backend/Migrations/20250204150718_AddedNoOfAllowedCylinders.cs
	namespace 	
backend
 
. 

Migrations 
{ 
public

 

partial

 
class

 %
AddedNoOfAllowedCylinders

 2
:

3 4
	Migration

5 >
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 
	AddColumn &
<& '
int' *
>* +
(+ ,
name 
: 
$str ,
,, -
table   
:   
$str   $
,  $ %
type!! 
:!! 
$str!! 
,!! 
nullable"" 
:"" 
true"" 
)"" 
;""  
migrationBuilder$$ 
.$$ 
	AddColumn$$ &
<$$& '
int$$' *
>$$* +
($$+ ,
name%% 
:%% 
$str%% 1
,%%1 2
table&& 
:&& 
$str&& $
,&&$ %
type'' 
:'' 
$str'' 
,'' 
nullable(( 
:(( 
true(( 
)(( 
;((  
migrationBuilder** 
.** 

InsertData** '
(**' (
table++ 
:++ 
$str++ $
,++$ %
columns,, 
:,, 
new,, 
[,, 
],, 
{,,  
$str,,! %
,,,% &
$str,,' 9
,,,9 :
$str,,; A
,,,A B
$str,,C S
},,T U
,,,U V
values-- 
:-- 
new-- 
object-- "
[--" #
,--# $
]--$ %
{.. 
{// 
$str// <
,//< =
null//> B
,//B C
$str//D K
,//K L
$str//M T
}//U V
,//V W
{00 
$str00 <
,00< =
null00> B
,00B C
$str00D J
,00J K
$str00L R
}00S T
,00T U
{11 
$str11 <
,11< =
null11> B
,11B C
$str11D M
,11M N
$str11O X
}11Y Z
}22 
)22 
;22 
}33 	
	protected66 
override66 
void66 
Down66  $
(66$ %
MigrationBuilder66% 5
migrationBuilder666 F
)66F G
{77 	
migrationBuilder88 
.88 

DeleteData88 '
(88' (
table99 
:99 
$str99 $
,99$ %
	keyColumn:: 
::: 
$str:: 
,::  
keyValue;; 
:;; 
$str;; @
);;@ A
;;;A B
migrationBuilder== 
.== 

DeleteData== '
(==' (
table>> 
:>> 
$str>> $
,>>$ %
	keyColumn?? 
:?? 
$str?? 
,??  
keyValue@@ 
:@@ 
$str@@ @
)@@@ A
;@@A B
migrationBuilderBB 
.BB 

DeleteDataBB '
(BB' (
tableCC 
:CC 
$strCC $
,CC$ %
	keyColumnDD 
:DD 
$strDD 
,DD  
keyValueEE 
:EE 
$strEE @
)EE@ A
;EEA B
migrationBuilderGG 
.GG 

DropColumnGG '
(GG' (
nameHH 
:HH 
$strHH ,
,HH, -
tableII 
:II 
$strII $
)II$ %
;II% &
migrationBuilderKK 
.KK 

DropColumnKK '
(KK' (
nameLL 
:LL 
$strLL 1
,LL1 2
tableMM 
:MM 
$strMM $
)MM$ %
;MM% &
migrationBuilderOO 
.OO 

InsertDataOO '
(OO' (
tablePP 
:PP 
$strPP $
,PP$ %
columnsQQ 
:QQ 
newQQ 
[QQ 
]QQ 
{QQ  
$strQQ! %
,QQ% &
$strQQ' 9
,QQ9 :
$strQQ; A
,QQA B
$strQQC S
}QQT U
,QQU V
valuesRR 
:RR 
newRR 
objectRR "
[RR" #
,RR# $
]RR$ %
{SS 
{TT 
$strTT <
,TT< =
nullTT> B
,TTB C
$strTTD M
,TTM N
$strTTO X
}TTY Z
,TTZ [
{UU 
$strUU <
,UU< =
nullUU> B
,UUB C
$strUUD J
,UUJ K
$strUUL R
}UUS T
,UUT U
{VV 
$strVV <
,VV< =
nullVV> B
,VVB C
$strVVD K
,VVK L
$strVVM T
}VVU V
}WW 
)WW 
;WW 
}XX 	
}YY 
}ZZ ÿ)
Y/Users/gayan/Developer/GasByGas/backend/Migrations/20250204143135_AddOutletIdToAppUser.cs
	namespace 	
backend
 
. 

Migrations 
{ 
public

 

partial

 
class

  
AddOutletIdToAppUser

 -
:

. /
	Migration

0 9
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 
	AddColumn &
<& '
int' *
>* +
(+ ,
name 
: 
$str  
,  !
table   
:   
$str   $
,  $ %
type!! 
:!! 
$str!! 
,!! 
nullable"" 
:"" 
true"" 
)"" 
;""  
migrationBuilder$$ 
.$$ 

InsertData$$ '
($$' (
table%% 
:%% 
$str%% $
,%%$ %
columns&& 
:&& 
new&& 
[&& 
]&& 
{&&  
$str&&! %
,&&% &
$str&&' 9
,&&9 :
$str&&; A
,&&A B
$str&&C S
}&&T U
,&&U V
values'' 
:'' 
new'' 
object'' "
[''" #
,''# $
]''$ %
{(( 
{)) 
$str)) <
,))< =
null))> B
,))B C
$str))D M
,))M N
$str))O X
}))Y Z
,))Z [
{** 
$str** <
,**< =
null**> B
,**B C
$str**D J
,**J K
$str**L R
}**S T
,**T U
{++ 
$str++ <
,++< =
null++> B
,++B C
$str++D K
,++K L
$str++M T
}++U V
},, 
),, 
;,, 
}-- 	
	protected00 
override00 
void00 
Down00  $
(00$ %
MigrationBuilder00% 5
migrationBuilder006 F
)00F G
{11 	
migrationBuilder22 
.22 

DeleteData22 '
(22' (
table33 
:33 
$str33 $
,33$ %
	keyColumn44 
:44 
$str44 
,44  
keyValue55 
:55 
$str55 @
)55@ A
;55A B
migrationBuilder77 
.77 

DeleteData77 '
(77' (
table88 
:88 
$str88 $
,88$ %
	keyColumn99 
:99 
$str99 
,99  
keyValue:: 
::: 
$str:: @
)::@ A
;::A B
migrationBuilder<< 
.<< 

DeleteData<< '
(<<' (
table== 
:== 
$str== $
,==$ %
	keyColumn>> 
:>> 
$str>> 
,>>  
keyValue?? 
:?? 
$str?? @
)??@ A
;??A B
migrationBuilderAA 
.AA 

DropColumnAA '
(AA' (
nameBB 
:BB 
$strBB  
,BB  !
tableCC 
:CC 
$strCC $
)CC$ %
;CC% &
migrationBuilderEE 
.EE 

InsertDataEE '
(EE' (
tableFF 
:FF 
$strFF $
,FF$ %
columnsGG 
:GG 
newGG 
[GG 
]GG 
{GG  
$strGG! %
,GG% &
$strGG' 9
,GG9 :
$strGG; A
,GGA B
$strGGC S
}GGT U
,GGU V
valuesHH 
:HH 
newHH 
objectHH "
[HH" #
,HH# $
]HH$ %
{II 
{JJ 
$strJJ <
,JJ< =
nullJJ> B
,JJB C
$strJJD J
,JJJ K
$strJJL R
}JJS T
,JJT U
{KK 
$strKK <
,KK< =
nullKK> B
,KKB C
$strKKD K
,KKK L
$strKKM T
}KKU V
,KKV W
{LL 
$strLL <
,LL< =
nullLL> B
,LLB C
$strLLD M
,LLM N
$strLLO X
}LLY Z
}MM 
)MM 
;MM 
}NN 	
}OO 
}PP …4
T/Users/gayan/Developer/GasByGas/backend/Migrations/20250204142215_UpdatetoAppUser.cs
	namespace 	
backend
 
. 

Migrations 
{ 
public

 

partial

 
class

 
UpdatetoAppUser

 (
:

) *
	Migration

+ 4
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 
RenameColumn )
() *
name 
: 
$str $
,$ %
table   
:   
$str   "
,  " #
newName!! 
:!! 
$str!! #
)!!# $
;!!$ %
migrationBuilder## 
.## 
	AddColumn## &
<##& '
string##' -
>##- .
(##. /
name$$ 
:$$ 
$str$$ ,
,$$, -
table%% 
:%% 
$str%% $
,%%$ %
type&& 
:&& 
$str&& $
,&&$ %
	maxLength'' 
:'' 
$num'' 
,'' 
nullable(( 
:(( 
true(( 
)(( 
;((  
migrationBuilder** 
.** 
	AddColumn** &
<**& '
bool**' +
>**+ ,
(**, -
name++ 
:++ 
$str++ !
,++! "
table,, 
:,, 
$str,, $
,,,$ %
type-- 
:-- 
$str-- 
,-- 
nullable.. 
:.. 
false.. 
,..  
defaultValue// 
:// 
false// #
)//# $
;//$ %
migrationBuilder11 
.11 

InsertData11 '
(11' (
table22 
:22 
$str22 $
,22$ %
columns33 
:33 
new33 
[33 
]33 
{33  
$str33! %
,33% &
$str33' 9
,339 :
$str33; A
,33A B
$str33C S
}33T U
,33U V
values44 
:44 
new44 
object44 "
[44" #
,44# $
]44$ %
{55 
{66 
$str66 <
,66< =
null66> B
,66B C
$str66D J
,66J K
$str66L R
}66S T
,66T U
{77 
$str77 <
,77< =
null77> B
,77B C
$str77D K
,77K L
$str77M T
}77U V
,77V W
{88 
$str88 <
,88< =
null88> B
,88B C
$str88D M
,88M N
$str88O X
}88Y Z
}99 
)99 
;99 
}:: 	
	protected== 
override== 
void== 
Down==  $
(==$ %
MigrationBuilder==% 5
migrationBuilder==6 F
)==F G
{>> 	
migrationBuilder?? 
.?? 

DeleteData?? '
(??' (
table@@ 
:@@ 
$str@@ $
,@@$ %
	keyColumnAA 
:AA 
$strAA 
,AA  
keyValueBB 
:BB 
$strBB @
)BB@ A
;BBA B
migrationBuilderDD 
.DD 

DeleteDataDD '
(DD' (
tableEE 
:EE 
$strEE $
,EE$ %
	keyColumnFF 
:FF 
$strFF 
,FF  
keyValueGG 
:GG 
$strGG @
)GG@ A
;GGA B
migrationBuilderII 
.II 

DeleteDataII '
(II' (
tableJJ 
:JJ 
$strJJ $
,JJ$ %
	keyColumnKK 
:KK 
$strKK 
,KK  
keyValueLL 
:LL 
$strLL @
)LL@ A
;LLA B
migrationBuilderNN 
.NN 

DropColumnNN '
(NN' (
nameOO 
:OO 
$strOO ,
,OO, -
tablePP 
:PP 
$strPP $
)PP$ %
;PP% &
migrationBuilderRR 
.RR 

DropColumnRR '
(RR' (
nameSS 
:SS 
$strSS !
,SS! "
tableTT 
:TT 
$strTT $
)TT$ %
;TT% &
migrationBuilderVV 
.VV 
RenameColumnVV )
(VV) *
nameWW 
:WW 
$strWW  
,WW  !
tableXX 
:XX 
$strXX "
,XX" #
newNameYY 
:YY 
$strYY '
)YY' (
;YY( )
migrationBuilder[[ 
.[[ 

InsertData[[ '
([[' (
table\\ 
:\\ 
$str\\ $
,\\$ %
columns]] 
:]] 
new]] 
[]] 
]]] 
{]]  
$str]]! %
,]]% &
$str]]' 9
,]]9 :
$str]]; A
,]]A B
$str]]C S
}]]T U
,]]U V
values^^ 
:^^ 
new^^ 
object^^ "
[^^" #
,^^# $
]^^$ %
{__ 
{`` 
$str`` <
,``< =
null``> B
,``B C
$str``D M
,``M N
$str``O X
}``Y Z
,``Z [
{aa 
$straa <
,aa< =
nullaa> B
,aaB C
$straaD K
,aaK L
$straaM T
}aaU V
,aaV W
{bb 
$strbb <
,bb< =
nullbb> B
,bbB C
$strbbD J
,bbJ K
$strbbL R
}bbS T
}cc 
)cc 
;cc 
}dd 	
}ee 
}ff ö:
Z/Users/gayan/Developer/GasByGas/backend/Migrations/20250113185910_DeliveryScheduleTable.cs
	namespace 	
backend
 
. 

Migrations 
{		 
public 

partial 
class !
DeliveryScheduleTable .
:/ 0
	Migration1 :
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 
CreateTable (
(( )
name   
:   
$str   )
,  ) *
columns!! 
:!! 
table!! 
=>!! !
new!!" %
{"" 
Id## 
=## 
table## 
.## 
Column## %
<##% &
int##& )
>##) *
(##* +
type##+ /
:##/ 0
$str##1 6
,##6 7
nullable##8 @
:##@ A
false##B G
)##G H
.$$ 

Annotation$$ #
($$# $
$str$$$ 8
,$$8 9
$str$$: @
)$$@ A
,$$A B
DeliveryDate%%  
=%%! "
table%%# (
.%%( )
Column%%) /
<%%/ 0
DateOnly%%0 8
>%%8 9
(%%9 :
type%%: >
:%%> ?
$str%%@ F
,%%F G
nullable%%H P
:%%P Q
false%%R W
)%%W X
,%%X Y
ConfirmedByAdmin&& $
=&&% &
table&&' ,
.&&, -
Column&&- 3
<&&3 4
bool&&4 8
>&&8 9
(&&9 :
type&&: >
:&&> ?
$str&&@ E
,&&E F
nullable&&G O
:&&O P
false&&Q V
)&&V W
,&&W X
NoOfUnitsInDelivery'' '
=''( )
table''* /
.''/ 0
Column''0 6
<''6 7
int''7 :
>'': ;
(''; <
type''< @
:''@ A
$str''B G
,''G H
nullable''I Q
:''Q R
false''S X
)''X Y
,''Y Z
OutletId(( 
=(( 
table(( $
.(($ %
Column((% +
<((+ ,
int((, /
>((/ 0
(((0 1
type((1 5
:((5 6
$str((7 <
,((< =
nullable((> F
:((F G
false((H M
)((M N
,((N O
DispatcherId))  
=))! "
table))# (
.))( )
Column))) /
<))/ 0
int))0 3
>))3 4
())4 5
type))5 9
:))9 :
$str)); @
,))@ A
nullable))B J
:))J K
false))L Q
)))Q R
}** 
,** 
constraints++ 
:++ 
table++ "
=>++# %
{,, 
table-- 
.-- 

PrimaryKey-- $
(--$ %
$str--% ;
,--; <
x--= >
=>--? A
x--B C
.--C D
Id--D F
)--F G
;--G H
}.. 
).. 
;.. 
migrationBuilder00 
.00 

InsertData00 '
(00' (
table11 
:11 
$str11 $
,11$ %
columns22 
:22 
new22 
[22 
]22 
{22  
$str22! %
,22% &
$str22' 9
,229 :
$str22; A
,22A B
$str22C S
}22T U
,22U V
values33 
:33 
new33 
object33 "
[33" #
,33# $
]33$ %
{44 
{55 
$str55 <
,55< =
null55> B
,55B C
$str55D M
,55M N
$str55O X
}55Y Z
,55Z [
{66 
$str66 <
,66< =
null66> B
,66B C
$str66D K
,66K L
$str66M T
}66U V
,66V W
{77 
$str77 <
,77< =
null77> B
,77B C
$str77D J
,77J K
$str77L R
}77S T
}88 
)88 
;88 
}99 	
	protected<< 
override<< 
void<< 
Down<<  $
(<<$ %
MigrationBuilder<<% 5
migrationBuilder<<6 F
)<<F G
{== 	
migrationBuilder>> 
.>> 
	DropTable>> &
(>>& '
name?? 
:?? 
$str?? )
)??) *
;??* +
migrationBuilderAA 
.AA 

DeleteDataAA '
(AA' (
tableBB 
:BB 
$strBB $
,BB$ %
	keyColumnCC 
:CC 
$strCC 
,CC  
keyValueDD 
:DD 
$strDD @
)DD@ A
;DDA B
migrationBuilderFF 
.FF 

DeleteDataFF '
(FF' (
tableGG 
:GG 
$strGG $
,GG$ %
	keyColumnHH 
:HH 
$strHH 
,HH  
keyValueII 
:II 
$strII @
)II@ A
;IIA B
migrationBuilderKK 
.KK 

DeleteDataKK '
(KK' (
tableLL 
:LL 
$strLL $
,LL$ %
	keyColumnMM 
:MM 
$strMM 
,MM  
keyValueNN 
:NN 
$strNN @
)NN@ A
;NNA B
migrationBuilderPP 
.PP 

InsertDataPP '
(PP' (
tableQQ 
:QQ 
$strQQ $
,QQ$ %
columnsRR 
:RR 
newRR 
[RR 
]RR 
{RR  
$strRR! %
,RR% &
$strRR' 9
,RR9 :
$strRR; A
,RRA B
$strRRC S
}RRT U
,RRU V
valuesSS 
:SS 
newSS 
objectSS "
[SS" #
,SS# $
]SS$ %
{TT 
{UU 
$strUU <
,UU< =
nullUU> B
,UUB C
$strUUD M
,UUM N
$strUUO X
}UUY Z
,UUZ [
{VV 
$strVV <
,VV< =
nullVV> B
,VVB C
$strVVD J
,VVJ K
$strVVL R
}VVS T
,VVT U
{WW 
$strWW <
,WW< =
nullWW> B
,WWB C
$strWWD K
,WWK L
$strWWM T
}WWU V
}XX 
)XX 
;XX 
}YY 	
}ZZ 
}[[ ⁄Q
S/Users/gayan/Developer/GasByGas/backend/Migrations/20250113182339_NewThreeTables.cs
	namespace 	
backend
 
. 

Migrations 
{		 
public 

partial 
class 
NewThreeTables '
:( )
	Migration* 3
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 
	AddColumn &
<& '
int' *
>* +
(+ ,
name   
:   
$str   
,   
table!! 
:!! 
$str!!  
,!!  !
type"" 
:"" 
$str"" 
,"" 
nullable## 
:## 
true## 
)## 
;##  
migrationBuilder%% 
.%% 
CreateTable%% (
(%%( )
name&& 
:&& 
$str&& !
,&&! "
columns'' 
:'' 
table'' 
=>'' !
new''" %
{(( 
Id)) 
=)) 
table)) 
.)) 
Column)) %
<))% &
int))& )
>))) *
())* +
type))+ /
:))/ 0
$str))1 6
,))6 7
nullable))8 @
:))@ A
false))B G
)))G H
.** 

Annotation** #
(**# $
$str**$ 8
,**8 9
$str**: @
)**@ A
,**A B
RequestDate++ 
=++  !
table++" '
.++' (
Column++( .
<++. /
DateOnly++/ 7
>++7 8
(++8 9
type++9 =
:++= >
$str++? E
,++E F
nullable++G O
:++O P
false++Q V
)++V W
,++W X
	ReadyDate,, 
=,, 
table,,  %
.,,% &
Column,,& ,
<,,, -
DateOnly,,- 5
>,,5 6
(,,6 7
type,,7 ;
:,,; <
$str,,= C
,,,C D
nullable,,E M
:,,M N
true,,O S
),,S T
,,,T U
ExpectedPickupDate-- &
=--' (
table--) .
.--. /
Column--/ 5
<--5 6
DateOnly--6 >
>--> ?
(--? @
type--@ D
:--D E
$str--F L
,--L M
nullable--N V
:--V W
false--X ]
)--] ^
,--^ _
Status.. 
=.. 
table.. "
..." #
Column..# )
<..) *
int..* -
>..- .
(... /
type../ 3
:..3 4
$str..5 :
,..: ;
nullable..< D
:..D E
false..F K
)..K L
,..L M
ConsumerType//  
=//! "
table//# (
.//( )
Column//) /
</// 0
int//0 3
>//3 4
(//4 5
type//5 9
://9 :
$str//; @
,//@ A
nullable//B J
://J K
false//L Q
)//Q R
,//R S#
IsEmpltyCylindersGivent00 +
=00, -
table00. 3
.003 4
Column004 :
<00: ;
bool00; ?
>00? @
(00@ A
type00A E
:00E F
$str00G L
,00L M
nullable00N V
:00V W
false00X ]
)00] ^
,00^ _
Price11 
=11 
table11 !
.11! "
Column11" (
<11( )
decimal11) 0
>110 1
(111 2
type112 6
:116 7
$str118 G
,11G H
	precision11I R
:11R S
$num11T V
,11V W
scale11X ]
:11] ^
$num11_ `
,11` a
nullable11b j
:11j k
true11l p
)11p q
,11q r
IsPaid22 
=22 
table22 "
.22" #
Column22# )
<22) *
bool22* .
>22. /
(22/ 0
type220 4
:224 5
$str226 ;
,22; <
nullable22= E
:22E F
false22G L
)22L M
,22M N
PaymentDate33 
=33  !
table33" '
.33' (
Column33( .
<33. /
DateOnly33/ 7
>337 8
(338 9
type339 =
:33= >
$str33? E
,33E F
nullable33G O
:33O P
true33Q U
)33U V
,33V W
	UserEmail44 
=44 
table44  %
.44% &
Column44& ,
<44, -
string44- 3
>443 4
(444 5
type445 9
:449 :
$str44; J
,44J K
	maxLength44L U
:44U V
$num44W Z
,44Z [
nullable44\ d
:44d e
false44f k
)44k l
,44l m
OutletId55 
=55 
table55 $
.55$ %
Column55% +
<55+ ,
int55, /
>55/ 0
(550 1
type551 5
:555 6
$str557 <
,55< =
nullable55> F
:55F G
false55H M
)55M N
,55N O
DeliveryScheduleId66 &
=66' (
table66) .
.66. /
Column66/ 5
<665 6
int666 9
>669 :
(66: ;
type66; ?
:66? @
$str66A F
,66F G
nullable66H P
:66P Q
true66R V
)66V W
}77 
,77 
constraints88 
:88 
table88 "
=>88# %
{99 
table:: 
.:: 

PrimaryKey:: $
(::$ %
$str::% 3
,::3 4
x::5 6
=>::7 9
x::: ;
.::; <
Id::< >
)::> ?
;::? @
};; 
);; 
;;; 
migrationBuilder== 
.== 

InsertData== '
(==' (
table>> 
:>> 
$str>> $
,>>$ %
columns?? 
:?? 
new?? 
[?? 
]?? 
{??  
$str??! %
,??% &
$str??' 9
,??9 :
$str??; A
,??A B
$str??C S
}??T U
,??U V
values@@ 
:@@ 
new@@ 
object@@ "
[@@" #
,@@# $
]@@$ %
{AA 
{BB 
$strBB <
,BB< =
nullBB> B
,BBB C
$strBBD M
,BBM N
$strBBO X
}BBY Z
,BBZ [
{CC 
$strCC <
,CC< =
nullCC> B
,CCB C
$strCCD J
,CCJ K
$strCCL R
}CCS T
,CCT U
{DD 
$strDD <
,DD< =
nullDD> B
,DDB C
$strDDD K
,DDK L
$strDDM T
}DDU V
}EE 
)EE 
;EE 
}FF 	
	protectedII 
overrideII 
voidII 
DownII  $
(II$ %
MigrationBuilderII% 5
migrationBuilderII6 F
)IIF G
{JJ 	
migrationBuilderKK 
.KK 
	DropTableKK &
(KK& '
nameLL 
:LL 
$strLL !
)LL! "
;LL" #
migrationBuilderNN 
.NN 

DeleteDataNN '
(NN' (
tableOO 
:OO 
$strOO $
,OO$ %
	keyColumnPP 
:PP 
$strPP 
,PP  
keyValueQQ 
:QQ 
$strQQ @
)QQ@ A
;QQA B
migrationBuilderSS 
.SS 

DeleteDataSS '
(SS' (
tableTT 
:TT 
$strTT $
,TT$ %
	keyColumnUU 
:UU 
$strUU 
,UU  
keyValueVV 
:VV 
$strVV @
)VV@ A
;VVA B
migrationBuilderXX 
.XX 

DeleteDataXX '
(XX' (
tableYY 
:YY 
$strYY $
,YY$ %
	keyColumnZZ 
:ZZ 
$strZZ 
,ZZ  
keyValue[[ 
:[[ 
$str[[ @
)[[@ A
;[[A B
migrationBuilder]] 
.]] 

DropColumn]] '
(]]' (
name^^ 
:^^ 
$str^^ 
,^^ 
table__ 
:__ 
$str__  
)__  !
;__! "
migrationBuilderaa 
.aa 

InsertDataaa '
(aa' (
tablebb 
:bb 
$strbb $
,bb$ %
columnscc 
:cc 
newcc 
[cc 
]cc 
{cc  
$strcc! %
,cc% &
$strcc' 9
,cc9 :
$strcc; A
,ccA B
$strccC S
}ccT U
,ccU V
valuesdd 
:dd 
newdd 
objectdd "
[dd" #
,dd# $
]dd$ %
{ee 
{ff 
$strff <
,ff< =
nullff> B
,ffB C
$strffD M
,ffM N
$strffO X
}ffY Z
,ffZ [
{gg 
$strgg <
,gg< =
nullgg> B
,ggB C
$strggD J
,ggJ K
$strggL R
}ggS T
,ggT U
{hh 
$strhh <
,hh< =
nullhh> B
,hhB C
$strhhD K
,hhK L
$strhhM T
}hhU V
}ii 
)ii 
;ii 
}jj 	
}kk 
}ll Ô6
V/Users/gayan/Developer/GasByGas/backend/Migrations/20250113151554_AddOutLetModelNew.cs
	namespace 	
backend
 
. 

Migrations 
{ 
public

 

partial

 
class

 
AddOutLetModelNew

 *
:

+ ,
	Migration

- 6
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str 
,  
columns   
:   
table   
=>   !
new  " %
{!! 
Id"" 
="" 
table"" 
."" 
Column"" %
<""% &
int""& )
>"") *
(""* +
type""+ /
:""/ 0
$str""1 6
,""6 7
nullable""8 @
:""@ A
false""B G
)""G H
.## 

Annotation## #
(### $
$str##$ 8
,##8 9
$str##: @
)##@ A
,##A B

OutletName$$ 
=$$  
table$$! &
.$$& '
Column$$' -
<$$- .
string$$. 4
>$$4 5
($$5 6
type$$6 :
:$$: ;
$str$$< K
,$$K L
	maxLength$$M V
:$$V W
$num$$X [
,$$[ \
nullable$$] e
:$$e f
false$$g l
)$$l m
,$$m n
OutletAddress%% !
=%%" #
table%%$ )
.%%) *
Column%%* 0
<%%0 1
string%%1 7
>%%7 8
(%%8 9
type%%9 =
:%%= >
$str%%? N
,%%N O
	maxLength%%P Y
:%%Y Z
$num%%[ ^
,%%^ _
nullable%%` h
:%%h i
true%%j n
)%%n o
,%%o p
City&& 
=&& 
table&&  
.&&  !
Column&&! '
<&&' (
string&&( .
>&&. /
(&&/ 0
type&&0 4
:&&4 5
$str&&6 D
,&&D E
	maxLength&&F O
:&&O P
$num&&Q S
,&&S T
nullable&&U ]
:&&] ^
false&&_ d
)&&d e
}'' 
,'' 
constraints(( 
:(( 
table(( "
=>((# %
{)) 
table** 
.** 

PrimaryKey** $
(**$ %
$str**% 1
,**1 2
x**3 4
=>**5 7
x**8 9
.**9 :
Id**: <
)**< =
;**= >
}++ 
)++ 
;++ 
migrationBuilder-- 
.-- 

InsertData-- '
(--' (
table.. 
:.. 
$str.. $
,..$ %
columns// 
:// 
new// 
[// 
]// 
{//  
$str//! %
,//% &
$str//' 9
,//9 :
$str//; A
,//A B
$str//C S
}//T U
,//U V
values00 
:00 
new00 
object00 "
[00" #
,00# $
]00$ %
{11 
{22 
$str22 <
,22< =
null22> B
,22B C
$str22D M
,22M N
$str22O X
}22Y Z
,22Z [
{33 
$str33 <
,33< =
null33> B
,33B C
$str33D J
,33J K
$str33L R
}33S T
,33T U
{44 
$str44 <
,44< =
null44> B
,44B C
$str44D K
,44K L
$str44M T
}44U V
}55 
)55 
;55 
}66 	
	protected99 
override99 
void99 
Down99  $
(99$ %
MigrationBuilder99% 5
migrationBuilder996 F
)99F G
{:: 	
migrationBuilder;; 
.;; 
	DropTable;; &
(;;& '
name<< 
:<< 
$str<< 
)<<  
;<<  !
migrationBuilder>> 
.>> 

DeleteData>> '
(>>' (
table?? 
:?? 
$str?? $
,??$ %
	keyColumn@@ 
:@@ 
$str@@ 
,@@  
keyValueAA 
:AA 
$strAA @
)AA@ A
;AAA B
migrationBuilderCC 
.CC 

DeleteDataCC '
(CC' (
tableDD 
:DD 
$strDD $
,DD$ %
	keyColumnEE 
:EE 
$strEE 
,EE  
keyValueFF 
:FF 
$strFF @
)FF@ A
;FFA B
migrationBuilderHH 
.HH 

DeleteDataHH '
(HH' (
tableII 
:II 
$strII $
,II$ %
	keyColumnJJ 
:JJ 
$strJJ 
,JJ  
keyValueKK 
:KK 
$strKK @
)KK@ A
;KKA B
migrationBuilderMM 
.MM 

InsertDataMM '
(MM' (
tableNN 
:NN 
$strNN $
,NN$ %
columnsOO 
:OO 
newOO 
[OO 
]OO 
{OO  
$strOO! %
,OO% &
$strOO' 9
,OO9 :
$strOO; A
,OOA B
$strOOC S
}OOT U
,OOU V
valuesPP 
:PP 
newPP 
objectPP "
[PP" #
,PP# $
]PP$ %
{QQ 
{RR 
$strRR <
,RR< =
nullRR> B
,RRB C
$strRRD M
,RRM N
$strRRO X
}RRY Z
,RRZ [
{SS 
$strSS <
,SS< =
nullSS> B
,SSB C
$strSSD J
,SSJ K
$strSSL R
}SSS T
,SST U
{TT 
$strTT <
,TT< =
nullTT> B
,TTB C
$strTTD K
,TTK L
$strTTM T
}TTU V
}UU 
)UU 
;UU 
}VV 	
}WW 
}XX ∆$
S/Users/gayan/Developer/GasByGas/backend/Migrations/20250113150334_AddOutletModel.cs
	namespace 	
backend
 
. 

Migrations 
{ 
public

 

partial

 
class

 
AddOutletModel

 '
:

( )
	Migration

* 3
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

InsertData '
(' (
table 
: 
$str $
,$ %
columns   
:   
new   
[   
]   
{    
$str  ! %
,  % &
$str  ' 9
,  9 :
$str  ; A
,  A B
$str  C S
}  T U
,  U V
values!! 
:!! 
new!! 
object!! "
[!!" #
,!!# $
]!!$ %
{"" 
{## 
$str## <
,##< =
null##> B
,##B C
$str##D M
,##M N
$str##O X
}##Y Z
,##Z [
{$$ 
$str$$ <
,$$< =
null$$> B
,$$B C
$str$$D J
,$$J K
$str$$L R
}$$S T
,$$T U
{%% 
$str%% <
,%%< =
null%%> B
,%%B C
$str%%D K
,%%K L
$str%%M T
}%%U V
}&& 
)&& 
;&& 
}'' 	
	protected** 
override** 
void** 
Down**  $
(**$ %
MigrationBuilder**% 5
migrationBuilder**6 F
)**F G
{++ 	
migrationBuilder,, 
.,, 

DeleteData,, '
(,,' (
table-- 
:-- 
$str-- $
,--$ %
	keyColumn.. 
:.. 
$str.. 
,..  
keyValue// 
:// 
$str// @
)//@ A
;//A B
migrationBuilder11 
.11 

DeleteData11 '
(11' (
table22 
:22 
$str22 $
,22$ %
	keyColumn33 
:33 
$str33 
,33  
keyValue44 
:44 
$str44 @
)44@ A
;44A B
migrationBuilder66 
.66 

DeleteData66 '
(66' (
table77 
:77 
$str77 $
,77$ %
	keyColumn88 
:88 
$str88 
,88  
keyValue99 
:99 
$str99 @
)99@ A
;99A B
migrationBuilder;; 
.;; 

InsertData;; '
(;;' (
table<< 
:<< 
$str<< $
,<<$ %
columns== 
:== 
new== 
[== 
]== 
{==  
$str==! %
,==% &
$str==' 9
,==9 :
$str==; A
,==A B
$str==C S
}==T U
,==U V
values>> 
:>> 
new>> 
object>> "
[>>" #
,>># $
]>>$ %
{?? 
{@@ 
$str@@ <
,@@< =
null@@> B
,@@B C
$str@@D K
,@@K L
$str@@M T
}@@U V
,@@V W
{AA 
$strAA <
,AA< =
nullAA> B
,AAB C
$strAAD M
,AAM N
$strAAO X
}AAY Z
,AAZ [
{BB 
$strBB <
,BB< =
nullBB> B
,BBB C
$strBBD J
,BBJ K
$strBBL R
}BBS T
}CC 
)CC 
;CC 
}DD 	
}EE 
}FF À0
`/Users/gayan/Developer/GasByGas/backend/Migrations/20250113100117_RemoveDuplicatedPhoneNumber.cs
	namespace 	
backend
 
. 

Migrations 
{ 
public

 

partial

 
class

 '
RemoveDuplicatedPhoneNumber

 4
:

5 6
	Migration

7 @
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 
AlterColumn (
<( )
string) /
>/ 0
(0 1
name 
: 
$str #
,# $
table   
:   
$str   $
,  $ %
type!! 
:!! 
$str!! %
,!!% &
nullable"" 
:"" 
true"" 
,"" 

oldClrType## 
:## 
typeof## "
(##" #
string### )
)##) *
,##* +
oldType$$ 
:$$ 
$str$$ '
,$$' (
oldMaxLength%% 
:%% 
$num%%  
,%%  !
oldNullable&& 
:&& 
true&& !
)&&! "
;&&" #
migrationBuilder(( 
.(( 

InsertData(( '
(((' (
table)) 
:)) 
$str)) $
,))$ %
columns** 
:** 
new** 
[** 
]** 
{**  
$str**! %
,**% &
$str**' 9
,**9 :
$str**; A
,**A B
$str**C S
}**T U
,**U V
values++ 
:++ 
new++ 
object++ "
[++" #
,++# $
]++$ %
{,, 
{-- 
$str-- <
,--< =
null--> B
,--B C
$str--D K
,--K L
$str--M T
}--U V
,--V W
{.. 
$str.. <
,..< =
null..> B
,..B C
$str..D M
,..M N
$str..O X
}..Y Z
,..Z [
{// 
$str// <
,//< =
null//> B
,//B C
$str//D J
,//J K
$str//L R
}//S T
}00 
)00 
;00 
}11 	
	protected44 
override44 
void44 
Down44  $
(44$ %
MigrationBuilder44% 5
migrationBuilder446 F
)44F G
{55 	
migrationBuilder66 
.66 

DeleteData66 '
(66' (
table77 
:77 
$str77 $
,77$ %
	keyColumn88 
:88 
$str88 
,88  
keyValue99 
:99 
$str99 @
)99@ A
;99A B
migrationBuilder;; 
.;; 

DeleteData;; '
(;;' (
table<< 
:<< 
$str<< $
,<<$ %
	keyColumn== 
:== 
$str== 
,==  
keyValue>> 
:>> 
$str>> @
)>>@ A
;>>A B
migrationBuilder@@ 
.@@ 

DeleteData@@ '
(@@' (
tableAA 
:AA 
$strAA $
,AA$ %
	keyColumnBB 
:BB 
$strBB 
,BB  
keyValueCC 
:CC 
$strCC @
)CC@ A
;CCA B
migrationBuilderEE 
.EE 
AlterColumnEE (
<EE( )
stringEE) /
>EE/ 0
(EE0 1
nameFF 
:FF 
$strFF #
,FF# $
tableGG 
:GG 
$strGG $
,GG$ %
typeHH 
:HH 
$strHH $
,HH$ %
	maxLengthII 
:II 
$numII 
,II 
nullableJJ 
:JJ 
trueJJ 
,JJ 

oldClrTypeKK 
:KK 
typeofKK "
(KK" #
stringKK# )
)KK) *
,KK* +
oldTypeLL 
:LL 
$strLL (
,LL( )
oldNullableMM 
:MM 
trueMM !
)MM! "
;MM" #
migrationBuilderOO 
.OO 

InsertDataOO '
(OO' (
tablePP 
:PP 
$strPP $
,PP$ %
columnsQQ 
:QQ 
newQQ 
[QQ 
]QQ 
{QQ  
$strQQ! %
,QQ% &
$strQQ' 9
,QQ9 :
$strQQ; A
,QQA B
$strQQC S
}QQT U
,QQU V
valuesRR 
:RR 
newRR 
objectRR "
[RR" #
,RR# $
]RR$ %
{SS 
{TT 
$strTT <
,TT< =
nullTT> B
,TTB C
$strTTD J
,TTJ K
$strTTL R
}TTS T
,TTT U
{UU 
$strUU <
,UU< =
nullUU> B
,UUB C
$strUUD M
,UUM N
$strUUO X
}UUY Z
,UUZ [
{VV 
$strVV <
,VV< =
nullVV> B
,VVB C
$strVVD K
,VVK L
$strVVM T
}VVU V
}WW 
)WW 
;WW 
}XX 	
}YY 
}ZZ å\
[/Users/gayan/Developer/GasByGas/backend/Migrations/20250113082929_UpdateAppUserMaxLength.cs
	namespace 	
backend
 
. 

Migrations 
{ 
public

 

partial

 
class

 "
UpdateAppUserMaxLength

 /
:

0 1
	Migration

2 ;
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 

DeleteData '
(' (
table 
: 
$str $
,$ %
	keyColumn 
: 
$str 
,  
keyValue 
: 
$str @
)@ A
;A B
migrationBuilder 
. 
AlterColumn (
<( )
string) /
>/ 0
(0 1
name 
: 
$str #
,# $
table   
:   
$str   $
,  $ %
type!! 
:!! 
$str!! $
,!!$ %
	maxLength"" 
:"" 
$num"" 
,"" 
nullable## 
:## 
true## 
,## 

oldClrType$$ 
:$$ 
typeof$$ "
($$" #
string$$# )
)$$) *
,$$* +
oldType%% 
:%% 
$str%% (
,%%( )
oldNullable&& 
:&& 
true&& !
)&&! "
;&&" #
migrationBuilder(( 
.(( 
AlterColumn(( (
<((( )
string(() /
>((/ 0
(((0 1
name)) 
:)) 
$str)) 
,)) 
table** 
:** 
$str** $
,**$ %
type++ 
:++ 
$str++ $
,++$ %
	maxLength,, 
:,, 
$num,, 
,,, 
nullable-- 
:-- 
true-- 
,-- 

oldClrType.. 
:.. 
typeof.. "
(.." #
string..# )
)..) *
,..* +
oldType// 
:// 
$str// (
,//( )
oldNullable00 
:00 
true00 !
)00! "
;00" #
migrationBuilder22 
.22 
AlterColumn22 (
<22( )
string22) /
>22/ 0
(220 1
name33 
:33 
$str33  
,33  !
table44 
:44 
$str44 $
,44$ %
type55 
:55 
$str55 %
,55% &
	maxLength66 
:66 
$num66 
,66 
nullable77 
:77 
true77 
,77 

oldClrType88 
:88 
typeof88 "
(88" #
string88# )
)88) *
,88* +
oldType99 
:99 
$str99 (
,99( )
oldNullable:: 
::: 
true:: !
)::! "
;::" #
migrationBuilder<< 
.<< 
AlterColumn<< (
<<<( )
string<<) /
><</ 0
(<<0 1
name== 
:== 
$str== 
,==  
table>> 
:>> 
$str>> $
,>>$ %
type?? 
:?? 
$str?? %
,??% &
	maxLength@@ 
:@@ 
$num@@ 
,@@ 
nullableAA 
:AA 
trueAA 
,AA 

oldClrTypeBB 
:BB 
typeofBB "
(BB" #
stringBB# )
)BB) *
,BB* +
oldTypeCC 
:CC 
$strCC (
,CC( )
oldNullableDD 
:DD 
trueDD !
)DD! "
;DD" #
migrationBuilderFF 
.FF 
	AddColumnFF &
<FF& '
stringFF' -
>FF- .
(FF. /
nameGG 
:GG 
$strGG 
,GG 
tableHH 
:HH 
$strHH $
,HH$ %
typeII 
:II 
$strII $
,II$ %
	maxLengthJJ 
:JJ 
$numJJ 
,JJ 
nullableKK 
:KK 
trueKK 
)KK 
;KK  
migrationBuilderMM 
.MM 

InsertDataMM '
(MM' (
tableNN 
:NN 
$strNN $
,NN$ %
columnsOO 
:OO 
newOO 
[OO 
]OO 
{OO  
$strOO! %
,OO% &
$strOO' 9
,OO9 :
$strOO; A
,OOA B
$strOOC S
}OOT U
,OOU V
valuesPP 
:PP 
newPP 
objectPP "
[PP" #
,PP# $
]PP$ %
{QQ 
{RR 
$strRR <
,RR< =
nullRR> B
,RRB C
$strRRD J
,RRJ K
$strRRL R
}RRS T
,RRT U
{SS 
$strSS <
,SS< =
nullSS> B
,SSB C
$strSSD M
,SSM N
$strSSO X
}SSY Z
,SSZ [
{TT 
$strTT <
,TT< =
nullTT> B
,TTB C
$strTTD K
,TTK L
$strTTM T
}TTU V
}UU 
)UU 
;UU 
}VV 	
	protectedYY 
overrideYY 
voidYY 
DownYY  $
(YY$ %
MigrationBuilderYY% 5
migrationBuilderYY6 F
)YYF G
{ZZ 	
migrationBuilder[[ 
.[[ 

DeleteData[[ '
([[' (
table\\ 
:\\ 
$str\\ $
,\\$ %
	keyColumn]] 
:]] 
$str]] 
,]]  
keyValue^^ 
:^^ 
$str^^ @
)^^@ A
;^^A B
migrationBuilder`` 
.`` 

DeleteData`` '
(``' (
tableaa 
:aa 
$straa $
,aa$ %
	keyColumnbb 
:bb 
$strbb 
,bb  
keyValuecc 
:cc 
$strcc @
)cc@ A
;ccA B
migrationBuilderee 
.ee 

DeleteDataee '
(ee' (
tableff 
:ff 
$strff $
,ff$ %
	keyColumngg 
:gg 
$strgg 
,gg  
keyValuehh 
:hh 
$strhh @
)hh@ A
;hhA B
migrationBuilderjj 
.jj 

DropColumnjj '
(jj' (
namekk 
:kk 
$strkk 
,kk 
tablell 
:ll 
$strll $
)ll$ %
;ll% &
migrationBuildernn 
.nn 
AlterColumnnn (
<nn( )
stringnn) /
>nn/ 0
(nn0 1
nameoo 
:oo 
$stroo #
,oo# $
tablepp 
:pp 
$strpp $
,pp$ %
typeqq 
:qq 
$strqq %
,qq% &
nullablerr 
:rr 
truerr 
,rr 

oldClrTypess 
:ss 
typeofss "
(ss" #
stringss# )
)ss) *
,ss* +
oldTypett 
:tt 
$strtt '
,tt' (
oldMaxLengthuu 
:uu 
$numuu  
,uu  !
oldNullablevv 
:vv 
truevv !
)vv! "
;vv" #
migrationBuilderxx 
.xx 
AlterColumnxx (
<xx( )
stringxx) /
>xx/ 0
(xx0 1
nameyy 
:yy 
$stryy 
,yy 
tablezz 
:zz 
$strzz $
,zz$ %
type{{ 
:{{ 
$str{{ %
,{{% &
nullable|| 
:|| 
true|| 
,|| 

oldClrType}} 
:}} 
typeof}} "
(}}" #
string}}# )
)}}) *
,}}* +
oldType~~ 
:~~ 
$str~~ '
,~~' (
oldMaxLength 
: 
$num  
,  !
oldNullable
ÄÄ 
:
ÄÄ 
true
ÄÄ !
)
ÄÄ! "
;
ÄÄ" #
migrationBuilder
ÇÇ 
.
ÇÇ 
AlterColumn
ÇÇ (
<
ÇÇ( )
string
ÇÇ) /
>
ÇÇ/ 0
(
ÇÇ0 1
name
ÉÉ 
:
ÉÉ 
$str
ÉÉ  
,
ÉÉ  !
table
ÑÑ 
:
ÑÑ 
$str
ÑÑ $
,
ÑÑ$ %
type
ÖÖ 
:
ÖÖ 
$str
ÖÖ %
,
ÖÖ% &
nullable
ÜÜ 
:
ÜÜ 
true
ÜÜ 
,
ÜÜ 

oldClrType
áá 
:
áá 
typeof
áá "
(
áá" #
string
áá# )
)
áá) *
,
áá* +
oldType
àà 
:
àà 
$str
àà (
,
àà( )
oldMaxLength
ââ 
:
ââ 
$num
ââ !
,
ââ! "
oldNullable
ää 
:
ää 
true
ää !
)
ää! "
;
ää" #
migrationBuilder
åå 
.
åå 
AlterColumn
åå (
<
åå( )
string
åå) /
>
åå/ 0
(
åå0 1
name
çç 
:
çç 
$str
çç 
,
çç  
table
éé 
:
éé 
$str
éé $
,
éé$ %
type
èè 
:
èè 
$str
èè %
,
èè% &
nullable
êê 
:
êê 
true
êê 
,
êê 

oldClrType
ëë 
:
ëë 
typeof
ëë "
(
ëë" #
string
ëë# )
)
ëë) *
,
ëë* +
oldType
íí 
:
íí 
$str
íí (
,
íí( )
oldMaxLength
ìì 
:
ìì 
$num
ìì !
,
ìì! "
oldNullable
îî 
:
îî 
true
îî !
)
îî! "
;
îî" #
migrationBuilder
ññ 
.
ññ 

InsertData
ññ '
(
ññ' (
table
óó 
:
óó 
$str
óó $
,
óó$ %
columns
òò 
:
òò 
new
òò 
[
òò 
]
òò 
{
òò  
$str
òò! %
,
òò% &
$str
òò' 9
,
òò9 :
$str
òò; A
,
òòA B
$str
òòC S
}
òòT U
,
òòU V
values
ôô 
:
ôô 
new
ôô 
object
ôô "
[
ôô" #
,
ôô# $
]
ôô$ %
{
öö 
{
õõ 
$str
õõ <
,
õõ< =
null
õõ> B
,
õõB C
$str
õõD K
,
õõK L
$str
õõM T
}
õõU V
,
õõV W
{
úú 
$str
úú <
,
úú< =
null
úú> B
,
úúB C
$str
úúD M
,
úúM N
$str
úúO X
}
úúY Z
,
úúZ [
{
ùù 
$str
ùù <
,
ùù< =
null
ùù> B
,
ùùB C
$str
ùùD J
,
ùùJ K
$str
ùùL R
}
ùùS T
}
ûû 
)
ûû 
;
ûû 
}
üü 	
}
†† 
}°° ˛ÿ
U/Users/gayan/Developer/GasByGas/backend/Migrations/20250113075023_InitialMigration.cs
	namespace 	
backend
 
. 

Migrations 
{		 
public 

partial 
class 
InitialMigration )
:* +
	Migration, 5
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str #
,# $
columns 
: 
table 
=> !
new" %
{ 
Id 
= 
table 
. 
Column %
<% &
string& ,
>, -
(- .
type. 2
:2 3
$str4 C
,C D
nullableE M
:M N
falseO T
)T U
,U V
Name 
= 
table  
.  !
Column! '
<' (
string( .
>. /
(/ 0
type0 4
:4 5
$str6 E
,E F
	maxLengthG P
:P Q
$numR U
,U V
nullableW _
:_ `
truea e
)e f
,f g
NormalizedName "
=# $
table% *
.* +
Column+ 1
<1 2
string2 8
>8 9
(9 :
type: >
:> ?
$str@ O
,O P
	maxLengthQ Z
:Z [
$num\ _
,_ `
nullablea i
:i j
truek o
)o p
,p q
ConcurrencyStamp $
=% &
table' ,
., -
Column- 3
<3 4
string4 :
>: ;
(; <
type< @
:@ A
$strB Q
,Q R
nullableS [
:[ \
true] a
)a b
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% 5
,5 6
x7 8
=>9 ;
x< =
.= >
Id> @
)@ A
;A B
} 
) 
; 
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str #
,# $
columns   
:   
table   
=>   !
new  " %
{!! 
Id"" 
="" 
table"" 
."" 
Column"" %
<""% &
string""& ,
>"", -
(""- .
type"". 2
:""2 3
$str""4 C
,""C D
nullable""E M
:""M N
false""O T
)""T U
,""U V
FullName## 
=## 
table## $
.##$ %
Column##% +
<##+ ,
string##, 2
>##2 3
(##3 4
type##4 8
:##8 9
$str##: I
,##I J
nullable##K S
:##S T
true##U Y
)##Y Z
,##Z [
NIC$$ 
=$$ 
table$$ 
.$$  
Column$$  &
<$$& '
string$$' -
>$$- .
($$. /
type$$/ 3
:$$3 4
$str$$5 D
,$$D E
nullable$$F N
:$$N O
true$$P T
)$$T U
,$$U V
PhoneNumber%% 
=%%  !
table%%" '
.%%' (
Column%%( .
<%%. /
string%%/ 5
>%%5 6
(%%6 7
type%%7 ;
:%%; <
$str%%= L
,%%L M
nullable%%N V
:%%V W
true%%X \
)%%\ ]
,%%] ^
Address&& 
=&& 
table&& #
.&&# $
Column&&$ *
<&&* +
string&&+ 1
>&&1 2
(&&2 3
type&&3 7
:&&7 8
$str&&9 H
,&&H I
nullable&&J R
:&&R S
true&&T X
)&&X Y
,&&Y Z
ConsumerType''  
=''! "
table''# (
.''( )
Column'') /
<''/ 0
int''0 3
>''3 4
(''4 5
type''5 9
:''9 :
$str''; @
,''@ A
nullable''B J
:''J K
true''L P
)''P Q
,''Q R
UserName(( 
=(( 
table(( $
.(($ %
Column((% +
<((+ ,
string((, 2
>((2 3
(((3 4
type((4 8
:((8 9
$str((: I
,((I J
	maxLength((K T
:((T U
$num((V Y
,((Y Z
nullable(([ c
:((c d
true((e i
)((i j
,((j k
NormalizedUserName)) &
=))' (
table))) .
.)). /
Column))/ 5
<))5 6
string))6 <
>))< =
())= >
type))> B
:))B C
$str))D S
,))S T
	maxLength))U ^
:))^ _
$num))` c
,))c d
nullable))e m
:))m n
true))o s
)))s t
,))t u
Email** 
=** 
table** !
.**! "
Column**" (
<**( )
string**) /
>**/ 0
(**0 1
type**1 5
:**5 6
$str**7 F
,**F G
	maxLength**H Q
:**Q R
$num**S V
,**V W
nullable**X `
:**` a
true**b f
)**f g
,**g h
NormalizedEmail++ #
=++$ %
table++& +
.+++ ,
Column++, 2
<++2 3
string++3 9
>++9 :
(++: ;
type++; ?
:++? @
$str++A P
,++P Q
	maxLength++R [
:++[ \
$num++] `
,++` a
nullable++b j
:++j k
true++l p
)++p q
,++q r
EmailConfirmed,, "
=,,# $
table,,% *
.,,* +
Column,,+ 1
<,,1 2
bool,,2 6
>,,6 7
(,,7 8
type,,8 <
:,,< =
$str,,> C
,,,C D
nullable,,E M
:,,M N
false,,O T
),,T U
,,,U V
PasswordHash--  
=--! "
table--# (
.--( )
Column--) /
<--/ 0
string--0 6
>--6 7
(--7 8
type--8 <
:--< =
$str--> M
,--M N
nullable--O W
:--W X
true--Y ]
)--] ^
,--^ _
SecurityStamp.. !
=.." #
table..$ )
...) *
Column..* 0
<..0 1
string..1 7
>..7 8
(..8 9
type..9 =
:..= >
$str..? N
,..N O
nullable..P X
:..X Y
true..Z ^
)..^ _
,.._ `
ConcurrencyStamp// $
=//% &
table//' ,
.//, -
Column//- 3
<//3 4
string//4 :
>//: ;
(//; <
type//< @
://@ A
$str//B Q
,//Q R
nullable//S [
://[ \
true//] a
)//a b
,//b c 
PhoneNumberConfirmed00 (
=00) *
table00+ 0
.000 1
Column001 7
<007 8
bool008 <
>00< =
(00= >
type00> B
:00B C
$str00D I
,00I J
nullable00K S
:00S T
false00U Z
)00Z [
,00[ \
TwoFactorEnabled11 $
=11% &
table11' ,
.11, -
Column11- 3
<113 4
bool114 8
>118 9
(119 :
type11: >
:11> ?
$str11@ E
,11E F
nullable11G O
:11O P
false11Q V
)11V W
,11W X

LockoutEnd22 
=22  
table22! &
.22& '
Column22' -
<22- .
DateTimeOffset22. <
>22< =
(22= >
type22> B
:22B C
$str22D T
,22T U
nullable22V ^
:22^ _
true22` d
)22d e
,22e f
LockoutEnabled33 "
=33# $
table33% *
.33* +
Column33+ 1
<331 2
bool332 6
>336 7
(337 8
type338 <
:33< =
$str33> C
,33C D
nullable33E M
:33M N
false33O T
)33T U
,33U V
AccessFailedCount44 %
=44& '
table44( -
.44- .
Column44. 4
<444 5
int445 8
>448 9
(449 :
type44: >
:44> ?
$str44@ E
,44E F
nullable44G O
:44O P
false44Q V
)44V W
}55 
,55 
constraints66 
:66 
table66 "
=>66# %
{77 
table88 
.88 

PrimaryKey88 $
(88$ %
$str88% 5
,885 6
x887 8
=>889 ;
x88< =
.88= >
Id88> @
)88@ A
;88A B
}99 
)99 
;99 
migrationBuilder;; 
.;; 
CreateTable;; (
(;;( )
name<< 
:<< 
$str<< (
,<<( )
columns== 
:== 
table== 
=>== !
new==" %
{>> 
Id?? 
=?? 
table?? 
.?? 
Column?? %
<??% &
int??& )
>??) *
(??* +
type??+ /
:??/ 0
$str??1 6
,??6 7
nullable??8 @
:??@ A
false??B G
)??G H
.@@ 

Annotation@@ #
(@@# $
$str@@$ 8
,@@8 9
$str@@: @
)@@@ A
,@@A B
RoleIdAA 
=AA 
tableAA "
.AA" #
ColumnAA# )
<AA) *
stringAA* 0
>AA0 1
(AA1 2
typeAA2 6
:AA6 7
$strAA8 G
,AAG H
nullableAAI Q
:AAQ R
falseAAS X
)AAX Y
,AAY Z
	ClaimTypeBB 
=BB 
tableBB  %
.BB% &
ColumnBB& ,
<BB, -
stringBB- 3
>BB3 4
(BB4 5
typeBB5 9
:BB9 :
$strBB; J
,BBJ K
nullableBBL T
:BBT U
trueBBV Z
)BBZ [
,BB[ \

ClaimValueCC 
=CC  
tableCC! &
.CC& '
ColumnCC' -
<CC- .
stringCC. 4
>CC4 5
(CC5 6
typeCC6 :
:CC: ;
$strCC< K
,CCK L
nullableCCM U
:CCU V
trueCCW [
)CC[ \
}DD 
,DD 
constraintsEE 
:EE 
tableEE "
=>EE# %
{FF 
tableGG 
.GG 

PrimaryKeyGG $
(GG$ %
$strGG% :
,GG: ;
xGG< =
=>GG> @
xGGA B
.GGB C
IdGGC E
)GGE F
;GGF G
tableHH 
.HH 

ForeignKeyHH $
(HH$ %
nameII 
:II 
$strII F
,IIF G
columnJJ 
:JJ 
xJJ  !
=>JJ" $
xJJ% &
.JJ& '
RoleIdJJ' -
,JJ- .
principalTableKK &
:KK& '
$strKK( 5
,KK5 6
principalColumnLL '
:LL' (
$strLL) -
,LL- .
onDeleteMM  
:MM  !
ReferentialActionMM" 3
.MM3 4
CascadeMM4 ;
)MM; <
;MM< =
}NN 
)NN 
;NN 
migrationBuilderPP 
.PP 
CreateTablePP (
(PP( )
nameQQ 
:QQ 
$strQQ (
,QQ( )
columnsRR 
:RR 
tableRR 
=>RR !
newRR" %
{SS 
IdTT 
=TT 
tableTT 
.TT 
ColumnTT %
<TT% &
intTT& )
>TT) *
(TT* +
typeTT+ /
:TT/ 0
$strTT1 6
,TT6 7
nullableTT8 @
:TT@ A
falseTTB G
)TTG H
.UU 

AnnotationUU #
(UU# $
$strUU$ 8
,UU8 9
$strUU: @
)UU@ A
,UUA B
UserIdVV 
=VV 
tableVV "
.VV" #
ColumnVV# )
<VV) *
stringVV* 0
>VV0 1
(VV1 2
typeVV2 6
:VV6 7
$strVV8 G
,VVG H
nullableVVI Q
:VVQ R
falseVVS X
)VVX Y
,VVY Z
	ClaimTypeWW 
=WW 
tableWW  %
.WW% &
ColumnWW& ,
<WW, -
stringWW- 3
>WW3 4
(WW4 5
typeWW5 9
:WW9 :
$strWW; J
,WWJ K
nullableWWL T
:WWT U
trueWWV Z
)WWZ [
,WW[ \

ClaimValueXX 
=XX  
tableXX! &
.XX& '
ColumnXX' -
<XX- .
stringXX. 4
>XX4 5
(XX5 6
typeXX6 :
:XX: ;
$strXX< K
,XXK L
nullableXXM U
:XXU V
trueXXW [
)XX[ \
}YY 
,YY 
constraintsZZ 
:ZZ 
tableZZ "
=>ZZ# %
{[[ 
table\\ 
.\\ 

PrimaryKey\\ $
(\\$ %
$str\\% :
,\\: ;
x\\< =
=>\\> @
x\\A B
.\\B C
Id\\C E
)\\E F
;\\F G
table]] 
.]] 

ForeignKey]] $
(]]$ %
name^^ 
:^^ 
$str^^ F
,^^F G
column__ 
:__ 
x__  !
=>__" $
x__% &
.__& '
UserId__' -
,__- .
principalTable`` &
:``& '
$str``( 5
,``5 6
principalColumnaa '
:aa' (
$straa) -
,aa- .
onDeletebb  
:bb  !
ReferentialActionbb" 3
.bb3 4
Cascadebb4 ;
)bb; <
;bb< =
}cc 
)cc 
;cc 
migrationBuilderee 
.ee 
CreateTableee (
(ee( )
nameff 
:ff 
$strff (
,ff( )
columnsgg 
:gg 
tablegg 
=>gg !
newgg" %
{hh 
LoginProviderii !
=ii" #
tableii$ )
.ii) *
Columnii* 0
<ii0 1
stringii1 7
>ii7 8
(ii8 9
typeii9 =
:ii= >
$strii? N
,iiN O
nullableiiP X
:iiX Y
falseiiZ _
)ii_ `
,ii` a
ProviderKeyjj 
=jj  !
tablejj" '
.jj' (
Columnjj( .
<jj. /
stringjj/ 5
>jj5 6
(jj6 7
typejj7 ;
:jj; <
$strjj= L
,jjL M
nullablejjN V
:jjV W
falsejjX ]
)jj] ^
,jj^ _
ProviderDisplayNamekk '
=kk( )
tablekk* /
.kk/ 0
Columnkk0 6
<kk6 7
stringkk7 =
>kk= >
(kk> ?
typekk? C
:kkC D
$strkkE T
,kkT U
nullablekkV ^
:kk^ _
truekk` d
)kkd e
,kke f
UserIdll 
=ll 
tablell "
.ll" #
Columnll# )
<ll) *
stringll* 0
>ll0 1
(ll1 2
typell2 6
:ll6 7
$strll8 G
,llG H
nullablellI Q
:llQ R
falsellS X
)llX Y
}mm 
,mm 
constraintsnn 
:nn 
tablenn "
=>nn# %
{oo 
tablepp 
.pp 

PrimaryKeypp $
(pp$ %
$strpp% :
,pp: ;
xpp< =
=>pp> @
newppA D
{ppE F
xppG H
.ppH I
LoginProviderppI V
,ppV W
xppX Y
.ppY Z
ProviderKeyppZ e
}ppf g
)ppg h
;pph i
tableqq 
.qq 

ForeignKeyqq $
(qq$ %
namerr 
:rr 
$strrr F
,rrF G
columnss 
:ss 
xss  !
=>ss" $
xss% &
.ss& '
UserIdss' -
,ss- .
principalTablett &
:tt& '
$strtt( 5
,tt5 6
principalColumnuu '
:uu' (
$struu) -
,uu- .
onDeletevv  
:vv  !
ReferentialActionvv" 3
.vv3 4
Cascadevv4 ;
)vv; <
;vv< =
}ww 
)ww 
;ww 
migrationBuilderyy 
.yy 
CreateTableyy (
(yy( )
namezz 
:zz 
$strzz '
,zz' (
columns{{ 
:{{ 
table{{ 
=>{{ !
new{{" %
{|| 
UserId}} 
=}} 
table}} "
.}}" #
Column}}# )
<}}) *
string}}* 0
>}}0 1
(}}1 2
type}}2 6
:}}6 7
$str}}8 G
,}}G H
nullable}}I Q
:}}Q R
false}}S X
)}}X Y
,}}Y Z
RoleId~~ 
=~~ 
table~~ "
.~~" #
Column~~# )
<~~) *
string~~* 0
>~~0 1
(~~1 2
type~~2 6
:~~6 7
$str~~8 G
,~~G H
nullable~~I Q
:~~Q R
false~~S X
)~~X Y
} 
, 
constraints
ÄÄ 
:
ÄÄ 
table
ÄÄ "
=>
ÄÄ# %
{
ÅÅ 
table
ÇÇ 
.
ÇÇ 

PrimaryKey
ÇÇ $
(
ÇÇ$ %
$str
ÇÇ% 9
,
ÇÇ9 :
x
ÇÇ; <
=>
ÇÇ= ?
new
ÇÇ@ C
{
ÇÇD E
x
ÇÇF G
.
ÇÇG H
UserId
ÇÇH N
,
ÇÇN O
x
ÇÇP Q
.
ÇÇQ R
RoleId
ÇÇR X
}
ÇÇY Z
)
ÇÇZ [
;
ÇÇ[ \
table
ÉÉ 
.
ÉÉ 

ForeignKey
ÉÉ $
(
ÉÉ$ %
name
ÑÑ 
:
ÑÑ 
$str
ÑÑ E
,
ÑÑE F
column
ÖÖ 
:
ÖÖ 
x
ÖÖ  !
=>
ÖÖ" $
x
ÖÖ% &
.
ÖÖ& '
RoleId
ÖÖ' -
,
ÖÖ- .
principalTable
ÜÜ &
:
ÜÜ& '
$str
ÜÜ( 5
,
ÜÜ5 6
principalColumn
áá '
:
áá' (
$str
áá) -
,
áá- .
onDelete
àà  
:
àà  !
ReferentialAction
àà" 3
.
àà3 4
Cascade
àà4 ;
)
àà; <
;
àà< =
table
ââ 
.
ââ 

ForeignKey
ââ $
(
ââ$ %
name
ää 
:
ää 
$str
ää E
,
ääE F
column
ãã 
:
ãã 
x
ãã  !
=>
ãã" $
x
ãã% &
.
ãã& '
UserId
ãã' -
,
ãã- .
principalTable
åå &
:
åå& '
$str
åå( 5
,
åå5 6
principalColumn
çç '
:
çç' (
$str
çç) -
,
çç- .
onDelete
éé  
:
éé  !
ReferentialAction
éé" 3
.
éé3 4
Cascade
éé4 ;
)
éé; <
;
éé< =
}
èè 
)
èè 
;
èè 
migrationBuilder
ëë 
.
ëë 
CreateTable
ëë (
(
ëë( )
name
íí 
:
íí 
$str
íí (
,
íí( )
columns
ìì 
:
ìì 
table
ìì 
=>
ìì !
new
ìì" %
{
îî 
UserId
ïï 
=
ïï 
table
ïï "
.
ïï" #
Column
ïï# )
<
ïï) *
string
ïï* 0
>
ïï0 1
(
ïï1 2
type
ïï2 6
:
ïï6 7
$str
ïï8 G
,
ïïG H
nullable
ïïI Q
:
ïïQ R
false
ïïS X
)
ïïX Y
,
ïïY Z
LoginProvider
ññ !
=
ññ" #
table
ññ$ )
.
ññ) *
Column
ññ* 0
<
ññ0 1
string
ññ1 7
>
ññ7 8
(
ññ8 9
type
ññ9 =
:
ññ= >
$str
ññ? N
,
ññN O
nullable
ññP X
:
ññX Y
false
ññZ _
)
ññ_ `
,
ññ` a
Name
óó 
=
óó 
table
óó  
.
óó  !
Column
óó! '
<
óó' (
string
óó( .
>
óó. /
(
óó/ 0
type
óó0 4
:
óó4 5
$str
óó6 E
,
óóE F
nullable
óóG O
:
óóO P
false
óóQ V
)
óóV W
,
óóW X
Value
òò 
=
òò 
table
òò !
.
òò! "
Column
òò" (
<
òò( )
string
òò) /
>
òò/ 0
(
òò0 1
type
òò1 5
:
òò5 6
$str
òò7 F
,
òòF G
nullable
òòH P
:
òòP Q
true
òòR V
)
òòV W
}
ôô 
,
ôô 
constraints
öö 
:
öö 
table
öö "
=>
öö# %
{
õõ 
table
úú 
.
úú 

PrimaryKey
úú $
(
úú$ %
$str
úú% :
,
úú: ;
x
úú< =
=>
úú> @
new
úúA D
{
úúE F
x
úúG H
.
úúH I
UserId
úúI O
,
úúO P
x
úúQ R
.
úúR S
LoginProvider
úúS `
,
úú` a
x
úúb c
.
úúc d
Name
úúd h
}
úúi j
)
úúj k
;
úúk l
table
ùù 
.
ùù 

ForeignKey
ùù $
(
ùù$ %
name
ûû 
:
ûû 
$str
ûû F
,
ûûF G
column
üü 
:
üü 
x
üü  !
=>
üü" $
x
üü% &
.
üü& '
UserId
üü' -
,
üü- .
principalTable
†† &
:
††& '
$str
††( 5
,
††5 6
principalColumn
°° '
:
°°' (
$str
°°) -
,
°°- .
onDelete
¢¢  
:
¢¢  !
ReferentialAction
¢¢" 3
.
¢¢3 4
Cascade
¢¢4 ;
)
¢¢; <
;
¢¢< =
}
££ 
)
££ 
;
££ 
migrationBuilder
•• 
.
•• 

InsertData
•• '
(
••' (
table
¶¶ 
:
¶¶ 
$str
¶¶ $
,
¶¶$ %
columns
ßß 
:
ßß 
new
ßß 
[
ßß 
]
ßß 
{
ßß  
$str
ßß! %
,
ßß% &
$str
ßß' 9
,
ßß9 :
$str
ßß; A
,
ßßA B
$str
ßßC S
}
ßßT U
,
ßßU V
values
®® 
:
®® 
new
®® 
object
®® "
[
®®" #
,
®®# $
]
®®$ %
{
©© 
{
™™ 
$str
™™ <
,
™™< =
null
™™> B
,
™™B C
$str
™™D K
,
™™K L
$str
™™M T
}
™™U V
,
™™V W
{
´´ 
$str
´´ <
,
´´< =
null
´´> B
,
´´B C
$str
´´D M
,
´´M N
$str
´´O X
}
´´Y Z
,
´´Z [
{
¨¨ 
$str
¨¨ <
,
¨¨< =
null
¨¨> B
,
¨¨B C
$str
¨¨D J
,
¨¨J K
$str
¨¨L R
}
¨¨S T
}
≠≠ 
)
≠≠ 
;
≠≠ 
migrationBuilder
ØØ 
.
ØØ 
CreateIndex
ØØ (
(
ØØ( )
name
∞∞ 
:
∞∞ 
$str
∞∞ 2
,
∞∞2 3
table
±± 
:
±± 
$str
±± )
,
±±) *
column
≤≤ 
:
≤≤ 
$str
≤≤  
)
≤≤  !
;
≤≤! "
migrationBuilder
¥¥ 
.
¥¥ 
CreateIndex
¥¥ (
(
¥¥( )
name
µµ 
:
µµ 
$str
µµ %
,
µµ% &
table
∂∂ 
:
∂∂ 
$str
∂∂ $
,
∂∂$ %
column
∑∑ 
:
∑∑ 
$str
∑∑ (
,
∑∑( )
unique
∏∏ 
:
∏∏ 
true
∏∏ 
,
∏∏ 
filter
ππ 
:
ππ 
$str
ππ 6
)
ππ6 7
;
ππ7 8
migrationBuilder
ªª 
.
ªª 
CreateIndex
ªª (
(
ªª( )
name
ºº 
:
ºº 
$str
ºº 2
,
ºº2 3
table
ΩΩ 
:
ΩΩ 
$str
ΩΩ )
,
ΩΩ) *
column
ææ 
:
ææ 
$str
ææ  
)
ææ  !
;
ææ! "
migrationBuilder
¿¿ 
.
¿¿ 
CreateIndex
¿¿ (
(
¿¿( )
name
¡¡ 
:
¡¡ 
$str
¡¡ 2
,
¡¡2 3
table
¬¬ 
:
¬¬ 
$str
¬¬ )
,
¬¬) *
column
√√ 
:
√√ 
$str
√√  
)
√√  !
;
√√! "
migrationBuilder
≈≈ 
.
≈≈ 
CreateIndex
≈≈ (
(
≈≈( )
name
∆∆ 
:
∆∆ 
$str
∆∆ 1
,
∆∆1 2
table
«« 
:
«« 
$str
«« (
,
««( )
column
»» 
:
»» 
$str
»»  
)
»»  !
;
»»! "
migrationBuilder
   
.
   
CreateIndex
   (
(
  ( )
name
ÀÀ 
:
ÀÀ 
$str
ÀÀ "
,
ÀÀ" #
table
ÃÃ 
:
ÃÃ 
$str
ÃÃ $
,
ÃÃ$ %
column
ÕÕ 
:
ÕÕ 
$str
ÕÕ )
)
ÕÕ) *
;
ÕÕ* +
migrationBuilder
œœ 
.
œœ 
CreateIndex
œœ (
(
œœ( )
name
–– 
:
–– 
$str
–– %
,
––% &
table
—— 
:
—— 
$str
—— $
,
——$ %
column
““ 
:
““ 
$str
““ ,
,
““, -
unique
”” 
:
”” 
true
”” 
,
”” 
filter
‘‘ 
:
‘‘ 
$str
‘‘ :
)
‘‘: ;
;
‘‘; <
}
’’ 	
	protected
ÿÿ 
override
ÿÿ 
void
ÿÿ 
Down
ÿÿ  $
(
ÿÿ$ %
MigrationBuilder
ÿÿ% 5
migrationBuilder
ÿÿ6 F
)
ÿÿF G
{
ŸŸ 	
migrationBuilder
⁄⁄ 
.
⁄⁄ 
	DropTable
⁄⁄ &
(
⁄⁄& '
name
€€ 
:
€€ 
$str
€€ (
)
€€( )
;
€€) *
migrationBuilder
›› 
.
›› 
	DropTable
›› &
(
››& '
name
ﬁﬁ 
:
ﬁﬁ 
$str
ﬁﬁ (
)
ﬁﬁ( )
;
ﬁﬁ) *
migrationBuilder
‡‡ 
.
‡‡ 
	DropTable
‡‡ &
(
‡‡& '
name
·· 
:
·· 
$str
·· (
)
··( )
;
··) *
migrationBuilder
„„ 
.
„„ 
	DropTable
„„ &
(
„„& '
name
‰‰ 
:
‰‰ 
$str
‰‰ '
)
‰‰' (
;
‰‰( )
migrationBuilder
ÊÊ 
.
ÊÊ 
	DropTable
ÊÊ &
(
ÊÊ& '
name
ÁÁ 
:
ÁÁ 
$str
ÁÁ (
)
ÁÁ( )
;
ÁÁ) *
migrationBuilder
ÈÈ 
.
ÈÈ 
	DropTable
ÈÈ &
(
ÈÈ& '
name
ÍÍ 
:
ÍÍ 
$str
ÍÍ #
)
ÍÍ# $
;
ÍÍ$ %
migrationBuilder
ÏÏ 
.
ÏÏ 
	DropTable
ÏÏ &
(
ÏÏ& '
name
ÌÌ 
:
ÌÌ 
$str
ÌÌ #
)
ÌÌ# $
;
ÌÌ$ %
}
ÓÓ 	
}
ÔÔ 
} Ó
>/Users/gayan/Developer/GasByGas/backend/Mappers/UserMappers.cs
	namespace 	
backend
 
. 
Mappers 
; 
public 
static 
class 
UserMappers 
{ 
public		 

static		 
ManagerReponseDto		 #
ToManagerReponseDto		$ 7
(		7 8
this		8 <
AppUser		= D
	userModel		E N
)		N O
{

 
return 
new 
ManagerReponseDto $
{ 	
Email 
= 
	userModel 
. 
Email #
,# $
FullName 
= 
	userModel  
.  !
FullName! )
,) *
	IsConfirm 
= 
	userModel !
.! "
	IsConfirm" +
,+ ,
ConsumerType 
= 
	userModel $
.$ %
ConsumerType% 1
,1 2
OutletId 
= 
	userModel  
.  !
OutletId! )
,) *
} 	
;	 

} 
public 

static 
ConsumerResponseDto %!
ToConsumerResponseDto& ;
(; <
this< @
AppUserA H
	userModelI R
)R S
{ 
return 
new 
ConsumerResponseDto &
{ 	
Email 
= 
	userModel 
. 
Email #
,# $
FullName 
= 
	userModel  
.  !
FullName! )
,) *
NIC 
= 
	userModel 
. 
Nic 
,   
BusinessRegistration  
=! "
	userModel# ,
., - 
BusinessRegistration- A
,A B
	IsConfirm 
= 
	userModel !
.! "
	IsConfirm" +
,+ ,
PhoneNumber 
= 
	userModel #
.# $
PhoneNumber$ /
,/ 0
Address 
= 
	userModel 
.  
Address  '
,' (
City   
=   
	userModel   
.   
City   !
,  ! "
UserType!! 
=!! 
	userModel!!  
.!!  !
ConsumerType!!! -
,!!- . 
NoOfCylindersAllowed""  
=""! "
	userModel""# ,
."", - 
NoOfCylindersAllowed""- A
,""A B%
RemainingCylindersAllowed## %
=##& '
	userModel##( 1
.##1 2%
RemainingCylindersAllowed##2 K
}$$ 	
;$$	 

}%% 
}&& Î
>/Users/gayan/Developer/GasByGas/backend/Mappers/TokenMapper.cs
	namespace 	
backend
 
. 
Mappers 
; 
public 
static 
class 
TokenMapper 
{ 
public

 

static

 
TokenResponseDto

 "
ToTokenResponseDto

# 5
(

5 6
this

6 :
GasToken

; C

tokenModel

D N
)

N O
{ 
return 
new 
TokenResponseDto #
(# $
)$ %
{ 	
Id 
= 

tokenModel 
. 
Id 
, 
RequestDate 
= 

tokenModel $
.$ %
RequestDate% 0
,0 1
	ReadyDate 
= 

tokenModel "
." #
	ReadyDate# ,
,, -
ExpectedPickupDate 
=  

tokenModel! +
.+ ,
ExpectedPickupDate, >
,> ?
Status 
= 

tokenModel 
.  
Status  &
,& '
Price 
= 

tokenModel 
. 
Price $
,$ %
IsPaid 
= 

tokenModel 
.  
IsPaid  &
,& '
PaymentDate 
= 

tokenModel $
.$ %
PaymentDate% 0
,0 1"
IsEmpltyCylindersGiven "
=# $

tokenModel% /
./ 0 
IsEmptyCylinderGiven0 D
,D E
UserType 
= 

tokenModel !
.! "
UserType" *
,* +
	UserEmail 
= 

tokenModel "
." #
	UserEmail# ,
,, -
OutletId 
= 

tokenModel !
.! "
OutletId" *
,* +
DeliveryScheduleId 
=  

tokenModel! +
.+ ,
DeliveryScheduleId, >
} 	
;	 

} 
public 

static 
GasToken %
ToTokenFromCreateTokenDto 4
(4 5
this5 9!
CreateTokenRequestDto: O
createTokenDtoP ^
,^ _
int` c
outletIdd l
,l m
stringn t
	userEmailu ~
)~ 
{	 Ä
return   
new   
GasToken   
{!! 	
RequestDate"" 
="" 
DateOnly"" "
.""" #
FromDateTime""# /
(""/ 0
DateTime""0 8
.""8 9
Now""9 <
)""< =
,""= >
ExpectedPickupDate## 
=##  
createTokenDto##! /
.##/ 0
ExpectedPickupDate##0 B
,##B C
Status$$ 
=$$ 
GasTokenStatus$$ #
.$$# $
Pending$$$ +
,$$+ ,
UserType%% 
=%% 
createTokenDto%% %
.%%% &
UserType%%& .
,%%. /
	UserEmail&& 
=&& 
	userEmail&& !
,&&! "
OutletId'' 
='' 
outletId'' 
}(( 	
;((	 

})) 
}** ƒ
>/Users/gayan/Developer/GasByGas/backend/Mappers/StockMapper.cs
	namespace 	
backend
 
. 
Mappers 
; 
public 
static 
class 
StockMapper 
{ 
public 

static "
StockRequestReponseDto (1
%StockRequestToStockRequestResponseDto) N
(N O
thisO S
StockRequestT `
modela f
)f g
{		 
return

 
new

 "
StockRequestReponseDto

 )
(

) *
)

* +
{ 	
Id 
= 
model 
. 
Id 
, 
OutletId 
= 
model 
. 
OutletId %
,% &
DeliveryScheduleId 
=  
model! &
.& '
DeliveryScheduleId' 9
,9 :
RequestedDate 
= 
model !
.! "
RequestedDate" /
,/ 0
CompletedDate 
= 
model !
.! "
CompletedDate" /
,/ 0
	Completed 
= 
model 
. 
	Completed '
,' (
NoOfUnitsRequired 
= 
model  %
.% &
NoOfUnitsRequired& 7
,7 8
NoOfUnitsDispatched 
=  !
model" '
.' (
NoOfUnitsDispatched( ;
,; <
} 	
;	 

} 
public 

static 
StockRequest )
StockRequestDtoToStockRequest <
(< =
this= A
StockRequestDtoB Q
dtoR U
)U V
{ 
return 
new 
StockRequest 
{ 	
OutletId 
= 
dto 
. 
OutletId #
,# $
RequestedDate 
= 
DateOnly $
.$ %
FromDateTime% 1
(1 2
DateTime2 :
.: ;
Now; >
)> ?
,? @
NoOfUnitsRequired 
= 
dto  #
.# $
NoOfUnitsRequired$ 5
,5 6
} 	
;	 

} 
}   ª
?/Users/gayan/Developer/GasByGas/backend/Mappers/OutletMapper.cs
	namespace 	
backend
 
. 
Mappers 
; 
public 
static 
class 
OutletMapper  
{ 
public		 

static		 
OutletResponseDto		 #(
ToOutletResponseDtofromModel		$ @
(		@ A
this		A E
Outlet		F L
outletModel		M X
)		X Y
{

 
return 
new 
OutletResponseDto $
{ 	
Id 
= 
outletModel 
. 
Id 
,  

OutletName 
= 
outletModel $
.$ %

OutletName% /
,/ 0
OutletAddress 
= 
outletModel '
.' (
OutletAddress( 5
,5 6
City 
= 
outletModel 
. 
City #
,# $
Stock 
= 
outletModel 
.  
Stock  %
} 	
;	 

} 
public 
static 
Outlet '
ToOutletModelFromRequestDto 5
(5 6
this6 :
NewOutletRequestDto; N
newOutletRequestDtoO b
)b c
{ 
return	 
new 
Outlet 
{	 


OutletName 
= 
newOutletRequestDto -
.- .

OutletName. 8
,8 9
OutletAddress 
= 
newOutletRequestDto 0
.0 1
OutletAddress1 >
,> ?
City 
= 
newOutletRequestDto '
.' (
City( ,
,, -
Stock 
= 
newOutletRequestDto (
.( )
Stock) .
}	 

;
 
} 
}   Õ
I/Users/gayan/Developer/GasByGas/backend/Mappers/DeliveryScheduleMapper.cs
	namespace 	
backend
 
. 
Mappers 
; 
public 
static 
class "
DeliveryScheduleMapper *
{ 
public		 

static		 
DeliveryResponseDto		 %-
!DeliverySheduleModelToResponseDto		& G
(		G H
this		H L
DeliverySchedule		M ]!
deliveryScheduleModel		^ s
)		s t
{

 
return 
new 
DeliveryResponseDto &
{ 	
Id 
= !
deliveryScheduleModel &
.& '
Id' )
,) *
DeliveryDate 
= !
deliveryScheduleModel 0
.0 1
DeliveryDate1 =
,= >
ConfirmedByAdmin 
= !
deliveryScheduleModel 4
.4 5
ConfirmedByAdmin5 E
,E F
NoOfUnitsInDelivery 
=  !!
deliveryScheduleModel" 7
.7 8
NoOfUnitsInDelivery8 K
,K L
OutletId 
= !
deliveryScheduleModel ,
., -
OutletId- 5
,5 6
DispatcherVehicleId 
=  !!
deliveryScheduleModel" 7
.7 8
DispatcherVehicleId8 K
,K L
} 	
;	 

} 
public 

static 
DeliverySchedule "-
!DeliveryRequestDtoToDeliveryModel# D
(D E
thisE I
DeliveryRequestDtoJ \
deliveryRequestDto] o
)o p
{ 
return 
new 
DeliverySchedule #
{ 	
DeliveryDate 
= 
deliveryRequestDto -
.- .
DeliveryDate. :
,: ;
ConfirmedByAdmin 
= 
deliveryRequestDto 1
.1 2
ConfirmedByAdmin2 B
,B C
NoOfUnitsInDelivery 
=  !
deliveryRequestDto" 4
.4 5
NoOfUnitsInDelivery5 H
,H I
OutletId 
= 
deliveryRequestDto )
.) *
OutletId* 2
,2 3
DispatcherVehicleId   
=    !
deliveryRequestDto  " 4
.  4 5
DispatcherVehicleId  5 H
,  H I
}!! 	
;!!	 

}"" 
}## ¥
C/Users/gayan/Developer/GasByGas/backend/Interfaces/ITokenService.cs
	namespace 	
backend
 
. 

Interfaces 
; 
public 
	interface 
ITokenService 
{ 
Task 
< 	
string	 
> 
CreateToken 
( 
AppUser $
user% )
)) *
;* +
}		 Ì
F/Users/gayan/Developer/GasByGas/backend/Interfaces/IStockRepository.cs
	namespace 	
backend
 
. 

Interfaces 
; 
public 
	interface 
IStockRepository !
{ 
Task 
< 	
List	 
< 
StockRequest 
> 
> $
GetAllStockRequestsAsync 5
(5 6
)6 7
;7 8
Task		 
<		 	
List			 
<		 
StockRequest		 
>		 
>		 .
"GetAllStockRequestsByOutletIdAsync		 ?
(		? @
int		@ C
outletId		D L
)		L M
;		M N
Task

 
<

 	
StockRequest

	 
?

 
>

 $
GetStockRequestByIdAsync

 0
(

0 1
int

1 4
id

5 7
)

7 8
;

8 9
Task 
< 	
List	 
< 
StockRequest 
> 
> 0
$GetAllStockRequestsByDeliveryIdAsync A
(A B
intB E

deliveryIdF P
)P Q
;Q R
Task 
< 	
StockRequest	 
> #
CreateStockRequestAsync .
(. /
StockRequest/ ;
?; <
stockRequest= I
)I J
;J K
Task 
< 	
StockRequest	 
? 
> #
UpdateStockRequestAsync /
(/ 0
int0 3
id4 6
,6 7(
StockRequestUpdateRequestDto8 T
stockRequestU a
)a b
;b c
Task 
< 	
StockRequest	 
? 
> #
DeleteStockRequestAsync /
(/ 0
int0 3
id4 6
)6 7
;7 8
} Î
A/Users/gayan/Developer/GasByGas/backend/Interfaces/ISmsService.cs
	namespace 	
backend
 
. 

Interfaces 
; 
public 
	interface 
ISmsService 
{ 
Task 
< 	
bool	 
> 
SendSmsAsync 
( 
string "
	recipient# ,
,, -
string. 4
message5 <
)< =
;= >
} î	
G/Users/gayan/Developer/GasByGas/backend/Interfaces/IOutletRepository.cs
	namespace 	
backend
 
. 

Interfaces 
; 
public 
	interface 
IOutletRepository "
{ 
Task 
< 	
List	 
< 
Outlet 
> 
> 
GetAllOutletsAsync )
() *
)* +
;+ ,
Task 
< 	
Outlet	 
> 
GetOutletByIdAsync #
(# $
int$ '
id( *
)* +
;+ ,
Task

 
<

 	
bool

	 
>

 
OutletExists

 
(

 
int

 
id

  "
)

" #
;

# $
Task 
< 	
Outlet	 
> 
CreateOutletAsync "
(" #
Outlet# )
outletModel* 5
)5 6
;6 7
Task 
< 	
bool	 
> 
DeleteOutletAsync  
(  !
int! $
id% '
)' (
;( )
} Ÿ
B/Users/gayan/Developer/GasByGas/backend/Interfaces/IMailService.cs
	namespace 	
backend
 
. 

Interfaces 
; 
public 
	interface 
IMailService 
{ 
Task 
< 	
bool	 
> 
SendEmailAsync 
( 
string $
toEmail% ,
,, -
string. 4
toName5 ;
,; <
string= C
subjectD K
,K L
stringM S
bodyT X
)X Y
;Y Z
} ¬
F/Users/gayan/Developer/GasByGas/backend/Interfaces/IKeyVaultService.cs
	namespace 	
backend
 
. 

Interfaces 
; 
public 
	interface 
IKeyVaultService !
{ 
Task 
< 	
string	 
> 
GetSecretAsync 
(  
string  &

secretName' 1
)1 2
;2 3
} õ
I/Users/gayan/Developer/GasByGas/backend/Interfaces/IGasTokenRepository.cs
	namespace 	
backend
 
. 

Interfaces 
; 
public 
	interface 
IGasTokenRepository $
{ 
public 

Task 
< 
List 
< 
GasToken 
> 
> 
GetAllAsync  +
(+ ,
), -
;- .
Task

 
<

 	
GasToken

	 
>

 
CreateAsync

 
(

 
GasToken

 '
gasTokenModel

( 5
)

5 6
;

6 7
Task 
< 	
GasToken	 
? 
> 
GetByIdAsync  
(  !
int! $
id% '
)' (
;( )
Task 
< 	
List	 
< 
GasToken 
> 
> 
GetAllByEmailAsync +
(+ ,
string, 2
email3 8
)8 9
;9 :
Task 
< 	
List	 
< 
GasToken 
> 
> 
GetAllByOutletAsync ,
(, -
int- 0
outletId1 9
)9 :
;: ;
Task 
< 	
GasToken	 
? 
> *
UpdateExpectedDateOfTokenAsync 2
(2 3
int3 6
id7 9
,9 :!
CreateTokenRequestDto; P
createTokenDtoQ _
)_ `
;` a
Task 
< 	
GasToken	 
? 
> 
UpdateTokenAsync $
($ %
int% (
id) +
,+ ,
UpdateTokenDto- ;
updateTokenDto< J
)J K
;K L
Task 
< 	
GasToken	 
? 
> 
DeleteTokenAsync $
($ %
int% (
id) +
)+ ,
;, -
Task 
< 	
List	 
< 
GasToken 
> 
> 1
%GetGasTokensByDeliveryScheduleIdAsync >
(> ?
int? B
deliveryScheduleIdC U
)U V
;V W
} À
I/Users/gayan/Developer/GasByGas/backend/Interfaces/IDeliveryRepository.cs
	namespace 	
backend
 
. 

Interfaces 
; 
public 
	interface 
IDeliveryRepository $
{ 
Task 
< 	
DeliverySchedule	 
> 
CreateAsync &
(& '
DeliverySchedule' 7!
deliveryScheduleModel8 M
)M N
;N O
Task		 
<		 	
bool			 
>		 
DeliveryExists		 
(		 
int		 !
id		" $
)		$ %
;		% &
Task

 
<

 	
List

	 
<

 
DeliverySchedule

 
>

 
>

  )
GetConfirmedDeliveriesForDate

! >
(

> ?
DateOnly

? G
date

H L
)

L M
;

M N
Task 
< 	
DeliverySchedule	 
? 
> 
GetById #
(# $
int$ '
id( *
)* +
;+ ,
Task 
< 	
List	 
< 
DeliverySchedule 
> 
>  
GetAllAsync! ,
(, -
)- .
;. /
Task 
< 	
DeliverySchedule	 
? 
> 
UpdateAsync '
(' (
int( +
id, .
,. /
DeliveryRequestDto0 B
scheduleRequestC R
)R S
;S T
Task 
< 	
bool	 
> 
DeleteAsync 
( 
int 
id !
)! "
;" #
} Ì
H/Users/gayan/Developer/GasByGas/backend/Interfaces/IAccountRepository.cs
	namespace 	
backend
 
. 

Interfaces 
; 
public 
	interface 
IAccountRepository #
{ 
Task 
< 	
bool	 
> 

UserExists 
( 
string  
email! &
)& '
;' (
Task 
< 	
List	 
< 
AppUser 
> 
> &
GetManagersByOutletIdAsync 2
(2 3
int3 6
outletId7 ?
)? @
;@ A
Task

 
<

 	
List

	 
<

 
AppUser

 
>

 
>

 
GetConsumersAsync

 )
(

) *
)

* +
;

+ ,
} Ó	
9/Users/gayan/Developer/GasByGas/backend/Enums/UserType.cs
	namespace 	
backend
 
. 
Enums 
; 
public 
enum 
UserType 
{ 
[ 

EnumMember 
( 
Value 
= 
$str "
)" #
]# $
Personal 
= 
$num 
, 
[		 

EnumMember		 
(		 
Value		 
=		 
$str		 "
)		" #
]		# $
Business

 
=

 
$num

 
,

 
[ 

EnumMember 
( 
Value 
= 
$str "
)" #
]# $

Industries 
= 
$num 
, 
[ 

EnumMember 
( 
Value 
= 
$str 
)  
]  !
Admin 	
=
 
$num 
, 
[ 

EnumMember 
( 
Value 
= 
$str !
)! "
]" #
Manager 
= 
$num 
, 
} Ø
?/Users/gayan/Developer/GasByGas/backend/Enums/GasTokenStatus.cs
	namespace 	
backend
 
. 
Enums 
; 
public 
enum 
GasTokenStatus 
{ 
[ 

EnumMember 
( 
Value 
= 
$str !
)! "
]" #
Pending 
= 
$num 
, 
[		 

EnumMember		 
(		 
Value		 
=		 
$str		 "
)		" #
]		# $
Assigned

 
=

 
$num

 
,

 
[ 

EnumMember 
( 
Value 
= 
$str #
)# $
]$ %
	Completed 
= 
$num 
, 
[ 

EnumMember 
( 
Value 
= 
$str "
)" #
]# $
	Cancelled 
= 
$num 
, 
} ∞	
Y/Users/gayan/Developer/GasByGas/backend/Dtos/StockRequest/StockRequestUpdateRequestDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
StockRequest #
;# $
public 
class (
StockRequestUpdateRequestDto )
{ 
public 

int 
? 
OutletId 
{ 
get 
; 
set  #
;# $
}% &
public 

DateOnly 
? 
CompletedDate "
{# $
get% (
;( )
set* -
;- .
}/ 0
public		 

bool		 
?		 
	Completed		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
public 

int 
? 
DeliveryScheduleId "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 

int 
? 
NoOfUnitsDispatched #
{$ %
get& )
;) *
set+ .
;. /
}0 1
} ñ
S/Users/gayan/Developer/GasByGas/backend/Dtos/StockRequest/StockRequestReponseDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
StockRequest #
;# $
public 
class "
StockRequestReponseDto #
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

required 
int 
OutletId  
{! "
get# &
;& '
set( +
;+ ,
}- .
public

 

DateOnly

 
RequestedDate

 !
{

" #
get

$ '
;

' (
set

) ,
;

, -
}

. /
public 

DateOnly 
? 
CompletedDate "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 

bool 
	Completed 
{ 
get 
;  
set! $
;$ %
}& '
=( )
false* /
;/ 0
public 

int 
? 
DeliveryScheduleId "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 

int 
NoOfUnitsRequired  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

int 
NoOfUnitsDispatched "
{# $
get% (
;( )
set* -
;- .
}/ 0
} ˛
L/Users/gayan/Developer/GasByGas/backend/Dtos/StockRequest/StockRequestDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
StockRequest #
;# $
public 
class 
StockRequestDto 
{ 
public 

required 
int 
OutletId  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

int 
NoOfUnitsRequired  
{! "
get# &
;& '
set( +
;+ ,
}- .
}

 Ô
H/Users/gayan/Developer/GasByGas/backend/Dtos/Outlet/OutletResponseDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
Outlet 
; 
public 
class 
OutletResponseDto 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

required 
string 

OutletName %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
public		 

string		 
?		 
OutletAddress		  
{		! "
get		# &
;		& '
set		( +
;		+ ,
}		- .
public 

required 
string 
City 
{  !
get" %
;% &
set' *
;* +
}, -
public 

int 
? 
Stock 
{ 
get 
; 
set  
;  !
}" #
} Á
J/Users/gayan/Developer/GasByGas/backend/Dtos/Outlet/NewOutletRequestDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
Outlet 
; 
public 
class 
NewOutletRequestDto  
{ 
public 

required 
string 

OutletName %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
public 

required 
string 
OutletAddress (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
public		 

required		 
string		 
City		 
{		  !
get		" %
;		% &
set		' *
;		* +
}		, -
public 

int 
? 
Stock 
{ 
get 
; 
set  
;  !
}" #
} ¿
J/Users/gayan/Developer/GasByGas/backend/Dtos/Notification/SmsRequestDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
Sms 
; 
public 
class 
SmsRequestDto 
{ 
[ 
Required 
] 
public 

string 
	Recepient 
{ 
get 
;  
set  #
;# $
}$ %
[

 
Required

 
]

 
public 

string 
Message 
{ 
get 
; 
set !
;! "
}" #
} ¥	
L/Users/gayan/Developer/GasByGas/backend/Dtos/Notification/EmailRequestDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
Sms 
; 
public 
class 
EmailRequestDto 
{ 
[ 
Required 
] 
public 

required 
string 
ToEmail "
{" #
get# &
;& '
set' *
;* +
}+ ,
[

 
Required

 
]

 
public 

required 
string 
ToName !
{" #
get$ '
;' (
set) ,
;, -
}. /
[ 
Required 
] 
public 

required 
string 
Subject "
{# $
get$ '
;' (
set( +
;+ ,
}, -
[ 
Required 
] 
public 

required 
string 
Body 
{  
get  #
;# $
set$ '
;' (
}( )
} Œ
G/Users/gayan/Developer/GasByGas/backend/Dtos/GasToken/UpdateTokenDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
GasToken 
;  
public 
class 
UpdateTokenDto 
{ 
public		 

DateOnly		 
?		 
	ReadyDate		 
{		  
get		! $
;		$ %
set		& )
;		) *
}		+ ,
public

 

required

 
DateOnly

 
ExpectedPickupDate

 /
{

0 1
get

2 5
;

5 6
set

7 :
;

: ;
}

< =
public 

required 
GasTokenStatus "
Status# )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
public 

bool #
IsEmpltyCylindersGivent '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
public 

bool 
IsPaid 
{ 
get 
; 
set !
;! "
}# $
=% &
false' ,
;, -
public 

DateOnly 
? 
PaymentDate  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

required 
string 
	UserEmail $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public 

int 
? 
DeliveryScheduleId "
{# $
get% (
;( )
set* -
;- .
}/ 0
} ß
I/Users/gayan/Developer/GasByGas/backend/Dtos/GasToken/TokenResponseDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
GasToken 
;  
public 
class 
TokenResponseDto 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public		 

required		 
DateOnly		 
RequestDate		 (
{		) *
get		+ .
;		. /
set		0 3
;		3 4
}		5 6
public 

DateOnly 
? 
	ReadyDate 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

required 
DateOnly 
ExpectedPickupDate /
{0 1
get2 5
;5 6
set7 :
;: ;
}< =
public 

required 
GasTokenStatus "
Status# )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
public 

required 
UserType 
UserType %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
public 

bool "
IsEmpltyCylindersGiven &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
public 

decimal 
? 
Price 
{ 
get 
;  
set! $
;$ %
}& '
public 

bool 
IsPaid 
{ 
get 
; 
set !
;! "
}# $
=% &
false' ,
;, -
public 

DateOnly 
? 
PaymentDate  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

required 
string 
	UserEmail $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public 

required 
int 
OutletId  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

int 
? 
DeliveryScheduleId "
{# $
get% (
;( )
set* -
;- .
}/ 0
} ¨
N/Users/gayan/Developer/GasByGas/backend/Dtos/GasToken/CreateTokenRequestDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
GasToken 
;  
public 
class !
CreateTokenRequestDto "
{ 
[		 
DataType		 
(		 
DataType		 
.		 
Date		 
)		 
]		 
public

 

required

 
DateOnly

 
ExpectedPickupDate

 /
{

0 1
get

2 5
;

5 6
set

7 :
;

: ;
}

< =
public 

required 
UserType 
UserType %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
} Ê

T/Users/gayan/Developer/GasByGas/backend/Dtos/DeliverySchedule/DeliveryResponseDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
DeliverySchedule '
;' (
public 
class 
DeliveryResponseDto  
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

required 
DateOnly 
DeliveryDate )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
public 

required 
bool 
ConfirmedByAdmin )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
public 

required 
int 
NoOfUnitsInDelivery +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
public		 

required		 
int		 
OutletId		  
{		! "
get		# &
;		& '
set		( +
;		+ ,
}		- .
public

 

required

 
string

 
DispatcherVehicleId

 .
{

/ 0
get

1 4
;

4 5
set

6 9
;

9 :
}

; <
} ∂

S/Users/gayan/Developer/GasByGas/backend/Dtos/DeliverySchedule/DeliveryRequestDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
DeliverySchedule '
;' (
public 
class 
DeliveryRequestDto 
{ 
public 

required 
DateOnly 
DeliveryDate )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
public 

required 
bool 
ConfirmedByAdmin )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
public		 

required		 
int		 
NoOfUnitsInDelivery		 +
{		, -
get		. 1
;		1 2
set		3 6
;		6 7
}		8 9
public

 

required

 
int

 
OutletId

  
{

! "
get

# &
;

& '
set

( +
;

+ ,
}

- .
[ 
	MaxLength 
( 
$num 
) 
] 
public 

required 
string 
DispatcherVehicleId .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
} Ô
N/Users/gayan/Developer/GasByGas/backend/Dtos/Account/UserRegisterRequestDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
Account 
; 
public 
class "
UserRegisterRequestDto #
{ 
[ 
Required 
] 
[		 
EmailAddress		 
]		 
public

 

required

 
string

 
Email

  
{

! "
get

# &
;

& '
set

( +
;

+ ,
}

- .
[ 
Required 
] 
public 

required 
string 
Password #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 
Required 
] 
public 

required 
string 
FullName #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 
	MaxLength 
( 
$num 
) 
] 
[ 
	MinLength 
( 
$num 
) 
] 
public 

string 
? 
NIC 
{ 
get 
; 
set !
;! "
}# $
[ 
	MaxLength 
( 
$num 
) 
] 
public 

string 
?  
BusinessRegistration '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
[ 
Required 
] 
[ 
	MaxLength 
( 
$num 
) 
] 
[ 
	MinLength 
( 
$num 
) 
] 
[ 
Phone 

]
 
public 

required 
string 
PhoneNumber &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
[!! 
	MaxLength!! 
(!! 
$num!! 
)!! 
]!! 
public"" 

string"" 
?"" 
Address"" 
{"" 
get""  
;""  !
set""" %
;""% &
}""' (
public$$ 

int$$ 
?$$ 
OutletId$$ 
{$$ 
get$$ 
;$$ 
set$$  #
;$$# $
}$$% &
[&& 
	MaxLength&& 
(&& 
$num&& 
)&& 
]&& 
public'' 

string'' 
?'' 
City'' 
{'' 
get'' 
;'' 
set'' "
;''" #
}''$ %
[)) 
Required)) 
])) 
[** 
EnumDataType** 
(** 
typeof** 
(** 
UserType** !
)**! "
)**" #
]**# $
public++ 

UserType++ 
UserType++ 
{++ 
get++ "
;++" #
set++$ '
;++' (
}++) *
public-- 

int-- 
?--  
NoOfCylindersAllowed-- $
{--% &
get--' *
;--* +
set--, /
;--/ 0
}--1 2
}// ß
E/Users/gayan/Developer/GasByGas/backend/Dtos/Account/UpdateUserDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
Account 
; 
public 
class 
UpdateUserDto 
{ 
public 

string 
? 
FullName 
{ 
get !
;! "
set# &
;& '
}( )
public 

int 
? 
OutletId 
{ 
get 
; 
set  #
;# $
}% &
public		 

string		 
?		 
NIC		 
{		 
get		 
;		 
set		 !
;		! "
}		# $
public 

string 
?  
BusinessRegistration '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
public 

string 
? 
PhoneNumber 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

UserType 
? 
ConsumerType !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 

string 
? 
Email 
{ 
get 
; 
set  #
;# $
}% &
public 

string 
? 
Address 
{ 
get  
;  !
set" %
;% &
}' (
public 

string 
? 
City 
{ 
get 
; 
set "
;" #
}$ %
} ﬂ
P/Users/gayan/Developer/GasByGas/backend/Dtos/Account/UpdateRemainingCylinders.cs
	namespace 	
backend
 
. 
Dtos 
. 
Account 
; 
public 
class $
UpdateRemainingCylinders %
{ 
public 

int %
RemainingCylindersAllowed (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
} æ
G/Users/gayan/Developer/GasByGas/backend/Dtos/Account/UpdateConfimDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
Account 
; 
public 
class 
UpdateConfimDto 
{ 
public 

bool 
	IsConfirm 
{ 
get 
;  
set! $
;$ %
}& '
} ‹
Q/Users/gayan/Developer/GasByGas/backend/Dtos/Account/UpdateAllowedCylindersDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
Account 
; 
public 
class %
UpdateAllowedCylindersDto &
{ 
public 

int  
NoOfCylindersAllowed #
{$ %
get& )
;) *
set+ .
;. /
}0 1
} à
J/Users/gayan/Developer/GasByGas/backend/Dtos/Account/NewUserResponseDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
Account 
; 
public 
class 
NewUserResponseDto 
{ 
public		 

required		 
string		 
Email		  
{		! "
get		# &
;		& '
set		( +
;		+ ,
}		- .
public

 

required

 
string

 
FullName

 #
{

$ %
get

& )
;

) *
set

+ .
;

. /
}

0 1
public 

string 
? 
NIC 
{ 
get 
; 
set !
;! "
}# $
public 

string 
?  
BusinessRegistration '
{' (
get( +
;+ ,
set, /
;/ 0
}0 1
public 

bool 
	IsConfirm 
{ 
get 
;  
set! $
;$ %
}& '
public 

int 
? 
OutletId 
{ 
get 
; 
set  #
;# $
}% &
public 

required 
string 
PhoneNumber &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
public 

string 
? 
Address 
{ 
get  
;  !
set" %
;% &
}' (
public 

string 
? 
City 
{ 
get 
; 
set "
;" #
}$ %
[ 
EnumDataType 
( 
typeof 
( 
UserType !
)! "
)" #
]# $
public 

UserType 
UserType 
{ 
get "
;" #
set$ '
;' (
}) *
public 

required 
string 
Token  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

int 
?  
NoOfCylindersAllowed $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public 

int 
? %
RemainingCylindersAllowed )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
} Ó
I/Users/gayan/Developer/GasByGas/backend/Dtos/Account/ManagerReponseDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
Account 
; 
public 
class 
ManagerReponseDto 
{ 
public 

string 
? 
Email 
{ 
get 
; 
set  #
;# $
}% &
public

 

string

 
?

 
FullName

 
{

 
get

 !
;

! "
set

# &
;

& '
}

( )
public 

bool 
	IsConfirm 
{ 
get 
;  
set! $
;$ %
}& '
public 

UserType 
? 
ConsumerType !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 

int 
? 
OutletId 
{ 
get 
; 
set  #
;# $
}% &
} ñ
@/Users/gayan/Developer/GasByGas/backend/Dtos/Account/LoginDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
Account 
; 
public 
class 
LoginDto 
{ 
[ 
Required 
] 
[ 
EmailAddress 
] 
public		 

required		 
string		 
Email		  
{		! "
get		# &
;		& '
set		( +
;		+ ,
}		- .
[

 
Required

 
]

 
public 

required 
string 
Password #
{$ %
get& )
;) *
set+ .
;. /
}0 1
} ≠
K/Users/gayan/Developer/GasByGas/backend/Dtos/Account/ConsumerResponseDto.cs
	namespace 	
backend
 
. 
Dtos 
. 
Account 
; 
public 
class 
ConsumerResponseDto  
{ 
public 

string 
? 
Email 
{ 
get 
; 
set  #
;# $
}% &
public		 

string		 
?		 
FullName		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
public

 

string

 
?

 
NIC

 
{

 
get

 
;

 
set

 "
;

" #
}

$ %
public 

string 
?  
BusinessRegistration '
{' (
get( +
;+ ,
set, /
;/ 0
}0 1
public 

bool 
	IsConfirm 
{ 
get 
;  
set! $
;$ %
}& '
public 

string 
? 
PhoneNumber 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

string 
? 
Address 
{ 
get  
;  !
set" %
;% &
}' (
public 

string 
? 
City 
{ 
get 
; 
set "
;" #
}$ %
[ 
EnumDataType 
( 
typeof 
( 
UserType !
)! "
)" #
]# $
public 

UserType 
? 
UserType 
{ 
get  #
;# $
set% (
;( )
}* +
public 

int 
?  
NoOfCylindersAllowed $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public 

int 
? %
RemainingCylindersAllowed )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
} ≤
D/Users/gayan/Developer/GasByGas/backend/Data/ApplicationDbContext.cs
	namespace 	
backend
 
. 
Data 
; 
public

 
class

  
ApplicationDbContext

 !
:

! "
IdentityDbContext

# 4
<

4 5
AppUser

5 <
>

< =
{ 
public 
 
ApplicationDbContext 
(  
DbContextOptions  0
dbContextOptions1 A
)A B
:B C
baseD H
(H I
dbContextOptionsI Y
)Y Z
{ 
} 
public 

DbSet 
< 
Outlet 
> 
Outlets  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

DbSet 
< 
GasToken 
> 
	GasTokens $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public 

DbSet 
< 
DeliverySchedule !
>! "
DeliverySchedules# 4
{5 6
get7 :
;: ;
set< ?
;? @
}A B
public 

DbSet 
< 
StockRequest 
? 
> 
StockRequests  -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
	protected 
override 
void 
OnConfiguring )
() *#
DbContextOptionsBuilder* A
optionsBuilderB P
)P Q
{ 
optionsBuilder 
. 
ConfigureWarnings (
(( )
warnings) 1
=>2 4
warnings 
. 
Ignore 
( 
RelationalEventId -
.- .&
PendingModelChangesWarning. H
)H I
)I J
;J K
} 
	protected 
override 
void 
OnModelCreating +
(+ ,
ModelBuilder, 8
modelBuilder9 E
)E F
{ 
base 
. 
OnModelCreating 
( 
modelBuilder )
)) *
;* +
List   
<   
IdentityRole   
>   
roles    
=  ! "
new  # &
List  ' +
<  + ,
IdentityRole  , 8
>  8 9
{!! 	
new"" 
IdentityRole"" 
{"" 
Name"" "
=""# $
$str""% +
,""+ ,
NormalizedName""- ;
=""< =
$str""> D
}""D E
,""E F
new## 
IdentityRole## 
{## 
Name## "
=### $
$str##% ,
,##, -
NormalizedName##. <
=##= >
$str##? F
}##F G
,##G H
new$$ 
IdentityRole$$ 
{$$ 
Name$$ "
=$$# $
$str$$% .
,$$. /
NormalizedName$$0 >
=$$? @
$str$$A J
}$$J K
,$$K L
}%% 	
;%%	 

modelBuilder&& 
.&& 
Entity&& 
<&& 
IdentityRole&& (
>&&( )
(&&) *
)&&* +
.&&+ ,
HasData&&, 3
(&&3 4
roles&&4 9
)&&9 :
;&&: ;
}(( 
}++ ˝_
F/Users/gayan/Developer/GasByGas/backend/Controllers/TokenController.cs
	namespace 	
backend
 
. 
Controllers 
; 
[		 
ApiController		 
]		 
[

 
Route

 
(

 
$str

 
)

 
]

 
public 
class 
TokenController 
: 
ControllerBase -
{ 
private 
readonly 
IGasTokenRepository (

_tokenRepo) 3
;3 4
private 
readonly 
IOutletRepository &
_outletRepo' 2
;2 3
private 
readonly 
IAccountRepository '
_accountRepo( 4
;4 5
private 
readonly 
IDeliveryRepository (
_deliveryRepo) 6
;6 7
public 

TokenController 
( 
IGasTokenRepository .
	tokenRepo/ 8
,8 9
IOutletRepository: K

outletRepoL V
,V W
IAccountRepositoryX j
accountRepok v
,v w 
IDeliveryRepository	x ã
deliveryRepo
å ò
)
ò ô
{ 

_tokenRepo 
= 
	tokenRepo 
; 
_accountRepo 
= 
accountRepo "
;" #
_outletRepo 
= 

outletRepo  
;  !
_deliveryRepo 
= 
deliveryRepo $
;$ %
} 
[ 
HttpGet 
] 
public 
async 
Task 
< 
IActionResult $
>$ %
GetAll& ,
(, -
)- .
{ 
var	 
	gasTokens 
= 
await 

_tokenRepo )
.) *
GetAllAsync* 5
(5 6
)6 7
;7 8
var	 
gasTokenDtos 
= 
	gasTokens %
.% &
Select& ,
(, -
s- .
=>/ 1
s2 3
.3 4
ToTokenResponseDto4 F
(F G
)G H
)H I
;I J
return  	 
Ok   
(   
gasTokenDtos   
)    
;    !
}!! 
[$$ 
HttpGet$$ 
($$ 
$str$$ 
)$$ 
]$$  
public%% 
async%% 
Task%% 
<%% 
IActionResult%% $
>%%$ %
GetAllByUser%%& 2
(%%2 3
[%%3 4
	FromRoute%%4 =
]%%= >
string%%? E
email%%F K
)%%K L
{&& 
var''	 
	gasTokens'' 
='' 
await'' 

_tokenRepo'' )
.'') *
GetAllByEmailAsync''* <
(''< =
email''= B
)''B C
;''C D
var((	 
gasToekDtos(( 
=(( 
	gasTokens(( $
.(($ %
Select((% +
(((+ ,
s((, -
=>((. 0
s((1 2
.((2 3
ToTokenResponseDto((3 E
(((E F
)((F G
)((G H
;((H I
return))	 
Ok)) 
()) 
gasToekDtos)) 
))) 
;))  
}** 
[-- 
HttpGet-- 
(-- 
$str-- #
)--# $
]--$ %
public.. 
async.. 
Task.. 
<.. 
IActionResult.. $
>..$ %
GetAllByOutlet..& 4
(..4 5
[..5 6
	FromRoute..6 ?
]..? @
int..A D
outletId..E M
)..M N
{// 
var00	 
	gasTokens00 
=00 
await00 

_tokenRepo00 )
.00) *
GetAllByOutletAsync00* =
(00= >
outletId00> F
)00F G
;00G H
var11	 
gasTokensDtos11 
=11 
	gasTokens11 &
.11& '
Select11' -
(11- .
s11. /
=>110 2
s113 4
.114 5
ToTokenResponseDto115 G
(11G H
)11H I
)11I J
;11J K
return22	 
Ok22 
(22 
gasTokensDtos22  
)22  !
;22! "
}33 
[66 
HttpGet66 
(66 
$str66 
)66 
]66 
public77 

async77 
Task77 
<77 
IActionResult77 #
>77# $
GetById77% ,
(77, -
[77- .
	FromRoute77. 7
]777 8
int779 <
id77= ?
)77? @
{88 
var99 
token99 
=99 
await99 

_tokenRepo99 $
.99$ %
GetByIdAsync99% 1
(991 2
id992 4
)994 5
;995 6
if:: 

(::
 
token:: 
==:: 
null:: 
):: 
{:: 
return::  
NotFound::! )
(::) *
)::* +
;::+ ,
}::, -
return<< 
Ok<< 
(<< 
token<< 
.<< 
ToTokenResponseDto<< *
(<<* +
)<<+ ,
)<<, -
;<<- .
}== 
[@@ 
HttpPost@@ 
]@@ 
publicAA 

asyncAA 
TaskAA 
<AA 
IActionResultAA #
>AA# $
CreateAA% +
(AA+ ,
[AA, -
	FromQueryAA- 6
]AA6 7
intAA8 ;
outletIdAA< D
,AAD E
[AAF G
	FromQueryAAG P
]AAP Q
stringAAQ W
consumerEmailAAX e
,AAe f
[AAg h
FromBodyAAh p
]AAp q"
CreateTokenRequestDto	AAr á
createTokenDto
AAà ñ
)
AAñ ó
{
AAó ò
ifCC 

(CC
 
!CC 
awaitCC 
_accountRepoCC 
.CC 

UserExistsCC )
(CC) *
consumerEmailCC* 7
)CC7 8
)CC8 9
{CC9 :
returnDD 

BadRequestDD 
(DD 
$strDD 3
)DD3 4
;DD4 5
}EE 	
ifGG 

(GG 
!GG 
awaitGG 
_outletRepoGG 
.GG 
OutletExistsGG +
(GG+ ,
outletIdGG, 4
)GG4 5
)GG5 6
{HH 	
returnII 

BadRequestII 
(II 
$strII 5
)II5 6
;II6 7
}JJ 	
varLL 

tokenModelLL 
=LL 
createTokenDtoLL '
.LL' (%
ToTokenFromCreateTokenDtoLL( A
(LLA B
outletIdLLB J
,LLJ K
consumerEmailLLL Y
)LLY Z
;LLZ [
awaitMM 

_tokenRepoMM 
.MM 
CreateAsyncMM $
(MM$ %

tokenModelMM% /
)MM/ 0
;MM0 1
returnNN 
CreatedAtActionNN 
(NN 
nameofNN %
(NN% &
GetByIdNN& -
)NN- .
,NN. /
newNN0 3
{NN3 4
idNN4 6
=NN7 8

tokenModelNN9 C
.NNC D
IdNND F
}NNF G
,NNG H

tokenModelNNI S
.NNS T
ToTokenResponseDtoNNT f
(NNf g
)NNg h
)NNh i
;NNi j
}PP 
[SS 
HttpPutSS 
(SS 
$strSS  
)SS  !
]SS! "
publicTT 

asyncTT 
TaskTT 
<TT 
IActionResultTT #
>TT# $#
UpdateTokenExpectedDateTT% <
(TT< =
[TT= >
	FromRouteTT> G
]TTG H
intTTI L
idTTM O
,TTO P
[TTQ R
FromBodyTTR Z
]TTZ [!
CreateTokenRequestDtoTT\ q
createTokenDto	TTr Ä
)
TTÄ Å
{UU 
varVV 

tokenModelVV 
=VV 
awaitVV 

_tokenRepoVV )
.VV) **
UpdateExpectedDateOfTokenAsyncVV* H
(VVH I
idVVI K
,VVK L
createTokenDtoVVM [
)VV[ \
;VV\ ]
ifWW 

(WW
 

tokenModelWW 
==WW 
nullWW 
)WW 
{WW 
returnWW %
NotFoundWW& .
(WW. /
)WW/ 0
;WW0 1
}WW1 2
returnXX 
OkXX 
(XX 

tokenModelXX 
.XX 
ToTokenResponseDtoXX /
(XX/ 0
)XX0 1
)XX1 2
;XX2 3
}YY 
[\\ 
HttpPut\\ 
(\\ 
$str\\ 
)\\ 
]\\ 
public]] 

async]] 
Task]] 
<]] 
IActionResult]] #
>]]# $
UpdateToken]]% 0
(]]0 1
[]]1 2
	FromRoute]]2 ;
]]]; <
int]]= @
id]]A C
,]]C D
[]]E F
FromBody]]F N
]]]N O
UpdateTokenDto]]P ^
updateTokenDto]]_ m
)]]m n
{]]n o
var`` 
user`` 
=`` 
await`` 
_accountRepo`` %
.``% &

UserExists``& 0
(``0 1
updateTokenDto``1 ?
.``? @
	UserEmail``@ I
)``I J
;``J K
ifbb 

(bb 
!bb 
userbb 
)bb 
{cc 	
returndd 

BadRequestdd 
(dd 
$strdd 3
)dd3 4
;dd4 5
}ee 	
ifhh 

(hh 
updateTokenDtohh 
.hh 
DeliveryScheduleIdhh -
!=hh. 0
nullhh1 5
)hh5 6
{ii 	
Consolejj 
.jj 
	WriteLinejj 
(jj 
$strjj <
)jj< =
;jj= >
varll 
deliverySchedulell  
=ll! "
awaitll# (
_deliveryRepoll) 6
.ll6 7
DeliveryExistsll7 E
(llE F
(llF G
intllG J
)llJ K
updateTokenDtollK Y
.llY Z
DeliveryScheduleIdllZ l
)lll m
;llm n
Consolemm 
.mm 
	WriteLinemm 
(mm 
deliverySchedulemm .
)mm. /
;mm/ 0
ifnn 
(nn 
!nn 
deliverySchedulenn  
)nn  !
{nn! "
returnnn" (

BadRequestnn) 3
(nn3 4
$strnn4 V
)nnV W
;nnW X
}nnX Y
}oo 	
varrr 

tokenModelrr 
=rr 
awaitrr 

_tokenReporr (
.rr( )
UpdateTokenAsyncrr) 9
(rr9 :
idrr: <
,rr< =
updateTokenDtorr> L
)rrL M
;rrM N
ifss 

(ss
 

tokenModelss 
==ss 
nullss 
)ss 
{ss 
returnss %
NotFoundss& .
(ss. /
)ss/ 0
;ss0 1
}ss1 2
returntt 
Oktt 
(tt 

tokenModeltt 
.tt 
ToTokenResponseDtott /
(tt/ 0
)tt0 1
)tt1 2
;tt2 3
}uu 
[xx 

HttpDeletexx 
]xx 
[yy 
RouteAttributeyy 
(yy 
$stryy 
)yy  
]yy  !
publiczz 

asynczz 
Taskzz 
<zz 
IActionResultzz #
>zz# $
DeleteGasTokenzz% 3
(zz3 4
[zz4 5
	FromRoutezz5 >
]zz> ?
intzz@ C
tokenIdzzD K
)zzK L
{{{ 
var|| 
gasTokenModel|| 
=|| 
await|| !

_tokenRepo||" ,
.||, -
DeleteTokenAsync||- =
(||= >
tokenId||> E
)||E F
;||F G
if}} 

(}} 
gasTokenModel}} 
==}} 
null}} !
)}}! "
{~~ 	
return 
NotFound 
( 
) 
; 
}
ÄÄ 	
return
ÉÉ 
	NoContent
ÉÉ 
(
ÉÉ 
)
ÉÉ 
;
ÉÉ 
}
ÑÑ 
}ÖÖ ¯`
F/Users/gayan/Developer/GasByGas/backend/Controllers/StockController.cs
	namespace 	
backend
 
. 
Controllers 
; 
[ 
ApiController 
] 
[		 
Route		 
(		 
$str		 
)		 
]		 
public

 
class

 
StockController

 
:

 
ControllerBase

 ,
{ 
private 
readonly 
IStockRepository %
_stockRepository& 6
;6 7
private 
readonly 
IOutletRepository &
_outletRepository' 8
;8 9
private 
readonly 
IDeliveryRepository (
_deliveryRepository) <
;< =
public 

StockController 
( 
IStockRepository +
stockRepository, ;
,; <
IOutletRepository= N
outletRepositoryO _
,_ `
IDeliveryRepositorya t
deliveryRepository	u á
)
á à
{ 
_stockRepository 
= 
stockRepository *
;* +
_outletRepository 
= 
outletRepository ,
;, -
_deliveryRepository 
= 
deliveryRepository 0
;0 1
} 
[ 
HttpGet 
] 
public 

async 
Task 
< 
IActionResult #
># $
GetAll% +
(+ ,
), -
{ 
var 
stockRequests 
= 
await !
_stockRepository" 2
.2 3$
GetAllStockRequestsAsync3 K
(K L
)L M
;M N
if 

( 
! 
stockRequests 
. 
Any 
( 
)  
)  !
return" (
new) ,
NoContentResult- <
(< =
)= >
;> ?
var #
stockRequestResponseDto #
=$ %
stockRequests& 3
.3 4
Select4 :
(: ;
s; <
=>= ?
s@ A
!A B
.B C1
%StockRequestToStockRequestResponseDtoC h
(h i
)i j
)j k
;k l
return 
Ok 
( #
stockRequestResponseDto )
)) *
;* +
} 
[!! 
HttpGet!! 
(!! 
$str!! 
)!! 
]!! 
public"" 

async"" 
Task"" 
<"" 
IActionResult"" #
>""# $
GetById""% ,
("", -
[""- .
	FromRoute"". 7
]""7 8
int""9 <
id""= ?
)""? @
{## 
var$$ 
stockRequest$$ 
=$$ 
await$$  
_stockRepository$$! 1
.$$1 2$
GetStockRequestByIdAsync$$2 J
($$J K
id$$K M
)$$M N
;$$N O
if%% 

(%% 
stockRequest%% 
==%% 
null%%  
)%%  !
return%%! '
NotFound%%( 0
(%%0 1
$str%%1 I
)%%I J
;%%J K
var&& #
stockRequestResponseDto&& #
=&&$ %
stockRequest&&& 2
.&&2 31
%StockRequestToStockRequestResponseDto&&3 X
(&&X Y
)&&Y Z
;&&Z [
return'' 
Ok'' 
('' #
stockRequestResponseDto'' )
)'') *
;''* +
}(( 
[** 
HttpGet** 
(** 
$str** 
)** 
]**  
public++ 

async++ 
Task++ 
<++ 
IActionResult++ #
>++# $%
GetStockRequestByOutletId++% >
(++> ?
[++? @
	FromRoute++@ I
]++I J
int++K N
id++O Q
)++Q R
{,, 
var.. 
stockRequests.. 
=.. 
await.. !
_stockRepository.." 2
...2 3.
"GetAllStockRequestsByOutletIdAsync..3 U
(..U V
id..V X
)..X Y
;..Y Z
if// 

(// 
!// 
stockRequests// 
.// 
Any// 
(// 
)//  
)//  !
return//" (
new//) ,
NoContentResult//- <
(//< =
)//= >
;//> ?
if00 

(00 
stockRequests00 
==00 
null00 !
)00! "
return00" (
NotFound00) 1
(001 2
$str002 Z
)00Z [
;00[ \
var22 $
stockRequestResponseDtos22 $
=22% &
stockRequests22' 4
.224 5
Select225 ;
(22; <
s22< =
=>22> @
s22A B
.22B C1
%StockRequestToStockRequestResponseDto22C h
(22h i
)22i j
)22j k
;22k l
return33 
Ok33 
(33 $
stockRequestResponseDtos33 *
)33* +
;33+ ,
}44 
[77 
HttpPost77 
]77 
public88 

async88 
Task88 
<88 
IActionResult88 #
>88# $!
CreateNewStockRequest88% :
(88: ;
[88; <
FromBody88< D
]88D E
StockRequestDto88F U
request88V ]
)88] ^
{99 
if== 

(== 
!== 

ModelState== 
.== 
IsValid== 
)==  
return==! '

BadRequest==( 2
(==2 3

ModelState==3 =
)=== >
;==> ?
var@@ 
outlet@@ 
=@@ 
await@@ 
_outletRepository@@ ,
.@@, -
OutletExists@@- 9
(@@9 :
request@@: A
.@@A B
OutletId@@B J
)@@J K
;@@K L
ifAA 

(AA 
!AA 
outletAA 
)AA 
returnAA 
NotFoundAA $
(AA$ %
$strAA% 6
)AA6 7
;AA7 8
varCC 

stockModelCC 
=CC 
requestCC  
.CC  !)
StockRequestDtoToStockRequestCC! >
(CC> ?
)CC? @
;CC@ A
varDD 
stockRequestDD 
=DD 
awaitDD  
_stockRepositoryDD! 1
.DD1 2#
CreateStockRequestAsyncDD2 I
(DDI J

stockModelDDJ T
)DDT U
;DDU V
ifEE 

(EE 
stockRequestEE 
==EE 
nullEE  
)EE  !
returnEE" (

BadRequestEE) 3
(EE3 4

ModelStateEE4 >
)EE> ?
;EE? @
varGG #
stockRequestResponseDtoGG #
=GG$ %
stockRequestGG& 2
.GG2 31
%StockRequestToStockRequestResponseDtoGG3 X
(GGX Y
)GGY Z
;GGZ [
returnHH 
CreatedAtActionHH 
(HH 
nameofHH %
(HH% &
GetByIdHH& -
)HH- .
,HH. /
newHH0 3
{HH3 4
idHH4 6
=HH7 8
stockRequestHH9 E
.HHE F
IdHHF H
}HHH I
,HHI J#
stockRequestResponseDtoHHK b
)HHb c
;HHc d
}JJ 
[LL 
HttpPutLL 
]LL 
[MM 
RouteMM 

(MM
 
$strMM 
)MM 
]MM 
publicNN 

asyncNN 
TaskNN 
<NN 
IActionResultNN #
>NN# $
UpdateStockRequestNN% 7
(NN7 8
[NN8 9
	FromRouteNN9 B
]NNB C
intNND G
idNNH J
,NNJ K
[NNL M
FromBodyNNM U
]NNU V(
StockRequestUpdateRequestDtoNNW s
requestNNt {
)NN{ |
{OO 
ifPP 

(PP 
!PP 

ModelStatePP 
.PP 
IsValidPP 
)PP  
returnPP! '

BadRequestPP( 2
(PP2 3

ModelStatePP3 =
)PP= >
;PP> ?
ifRR 

(RR 
requestRR 
.RR 
OutletIdRR 
!=RR 
nullRR  $
)RR$ %
{SS 	
varTT 
outletTT 
=TT 
awaitTT 
_outletRepositoryTT 0
.TT0 1
OutletExistsTT1 =
(TT= >
(TT> ?
intTT? B
)TTB C
requestTTC J
.TTJ K
OutletIdTTK S
)TTS T
;TTT U
ifUU 
(UU 
!UU 
outletUU 
)UU 
returnUU 
NotFoundUU  (
(UU( )
$strUU) E
)UUE F
;UUF G
}VV 	
ifXX 

(XX 
requestXX 
.XX 
DeliveryScheduleIdXX &
!=XX' )
nullXX* .
)XX. /
{YY 	
varZZ 
deliveryZZ 
=ZZ 
awaitZZ  
_deliveryRepositoryZZ! 4
.ZZ4 5
DeliveryExistsZZ5 C
(ZZC D
(ZZD E
intZZE H
)ZZH I
requestZZI P
.ZZP Q
DeliveryScheduleIdZZQ c
)ZZc d
;ZZd e
if[[ 
([[ 
![[ 
delivery[[ 
)[[ 
return[[ !
NotFound[[" *
([[* +
$str[[+ G
)[[G H
;[[H I
}\\ 	
var^^ 
stockRequest^^ 
=^^ 
await^^  
_stockRepository^^! 1
.^^1 2#
UpdateStockRequestAsync^^2 I
(^^I J
id^^J L
,^^L M
request^^N U
)^^U V
;^^V W
if__ 

(__ 
stockRequest__ 
==__ 
null__  
)__  !
return__" (

BadRequest__) 3
(__3 4

ModelState__4 >
)__> ?
;__? @
varaa #
stockRequestResponseDtoaa #
=aa$ %
stockRequestaa& 2
.aa2 31
%StockRequestToStockRequestResponseDtoaa3 X
(aaX Y
)aaY Z
;aaZ [
returnbb 
Okbb 
(bb #
stockRequestResponseDtobb )
)bb) *
;bb* +
}cc 
[ee 

HttpDeleteee 
(ee 
$stree 
)ee 
]ee 
publicff 

asyncff 
Taskff 
<ff 
IActionResultff #
>ff# $
DeleteStockRequestff% 7
(ff7 8
[ff8 9
	FromRouteff9 B
]ffB C
intffD G
idffH J
)ffJ K
{gg 
tryhh 
{ii 	
varjj  
existingStockRequestjj $
=jj% &
awaitjj' ,
_stockRepositoryjj- =
.jj= >$
GetStockRequestByIdAsyncjj> V
(jjV W
idjjW Y
)jjY Z
;jjZ [
ifkk 
(kk  
existingStockRequestkk $
==kk% '
nullkk( ,
)kk, -
returnll 
NotFoundll 
(ll  
$strll  9
)ll9 :
;ll: ;
varnn 
resultnn 
=nn 
awaitnn 
_stockRepositorynn /
.nn/ 0#
DeleteStockRequestAsyncnn0 G
(nnG H
idnnH J
)nnJ K
;nnK L
ifoo 
(oo 
resultoo 
==oo 
nulloo 
)oo 
returnpp 

StatusCodepp !
(pp! "
$numpp" %
,pp% &
$strpp' \
)pp\ ]
;pp] ^
returnrr 
Okrr 
(rr 
newrr 
{rr 
messagerr #
=rr$ %
$"rr& (
$strrr( >
{rr> ?
idrr? A
}rrA B
$strrrB W
"rrW X
}rrY Z
)rrZ [
;rr[ \
}ss 	
catchtt 
(tt 
	Exceptiontt 
ett 
)tt 
{uu 	
Consolevv 
.vv 
	WriteLinevv 
(vv 
evv 
)vv  
;vv  !
returnww 

StatusCodeww 
(ww 
$numww !
,ww! "
$strww# X
)wwX Y
;wwY Z
}xx 	
}yy 
}{{ â
J/Users/gayan/Developer/GasByGas/backend/Controllers/SchedulerController.cs
	namespace 	
backend
 
. 
Controllers 
; 
[ 
ApiController 
] 
[ 
Route 
( 
$str 
) 
] 
public 
class 
SchedulerController  
:  !
ControllerBase" 0
{		 
private

 
readonly

 
SchedulerService

 %
_schedulerService

& 7
;

7 8
public 

SchedulerController 
( 
SchedulerService /
schedulerService0 @
)@ A
{ 
_schedulerService 
= 
schedulerService ,
;, -
} 
[ 
HttpPost 
] 
[ 
Route 

(
 
$str 
) 
] 
public 

async 
Task 
< 
IActionResult #
># $
RunNow% +
(+ ,
), -
{ 
await 
_schedulerService 
.  
RunNow  &
(& '
)' (
;( )
return 
Ok 
( 
$str (
)( )
;) *
} 
} ∑/
G/Users/gayan/Developer/GasByGas/backend/Controllers/OutletController.cs
	namespace 	
backend
 
. 
Controllers 
; 
[		 
ApiController		 
]		 
[

 
Route

 
(

 
$str

 
)

 
]

 
public 
class 
OutletController 
: 
ControllerBase  .
{ 
private 
readonly 
IOutletRepository &
_outletRepo' 2
;2 3
public 

OutletController 
( 
IOutletRepository -

outletRepo. 8
)8 9
{ 
_outletRepo 
= 

outletRepo  
;  !
} 
[ 
HttpGet 
] 
public 

async 
Task 
< 
ActionResult "
<" #
IEnumerable# .
<. /
OutletResponseDto/ @
>@ A
>A B
>B C
GetAllD J
(J K
)K L
{ 
var 
outlets 
= 
await 
_outletRepo '
.' (
GetAllOutletsAsync( :
(: ;
); <
;< =
var 

outletDtos 
= 
outlets  
.  !
Select! '
(' (
o( )
=>* ,
o- .
.. /(
ToOutletResponseDtofromModel/ K
(K L
)L M
)M N
;N O
return 
Ok 
( 

outletDtos 
) 
; 
} 
[ 
HttpGet 
( 
$str 
) 
] 
public 

async 
Task 
< 
IActionResult #
># $
GetById% ,
(, -
[- .
	FromRoute. 7
]7 8
int9 <
id= ?
)? @
{ 
var   
outlet   
=   
await   
_outletRepo   &
.  & '
GetOutletByIdAsync  ' 9
(  9 :
id  : <
)  < =
;  = >
if!! 

(!! 
outlet!! 
==!! 
null!! 
)!! 
{"" 	
return## 
NotFound## 
(## 
)## 
;## 
}$$ 	
return%% 
Ok%% 
(%% 
outlet%% 
.%% (
ToOutletResponseDtofromModel%% 5
(%%5 6
)%%6 7
)%%7 8
;%%8 9
}&& 
[(( 
HttpPost(( 
](( 
public)) 

async)) 
Task)) 
<)) 
ActionResult)) "
>))" #
CreateOutlet))$ 0
())0 1
[))1 2
FromBody))2 :
])): ;
NewOutletRequestDto))< O
createOutletDto))P _
)))_ `
{** 
if++ 

(++
 
!++ 

ModelState++ 
.++ 
IsValid++ 
)++ 
return++  &

BadRequest++' 1
(++1 2

ModelState++2 <
)++< =
;++= >
var-- 
outletModel-- 
=-- 
createOutletDto-- )
.--) *'
ToOutletModelFromRequestDto--* E
(--E F
)--F G
;--G H
await.. 
_outletRepo.. 
... 
CreateOutletAsync.. +
(..+ ,
outletModel.., 7
)..7 8
;..8 9
return// 
CreatedAtAction// 
(// 
nameof// %
(//% &
GetById//& -
)//- .
,//. /
new//0 3
{//4 5
id//6 8
=//9 :
outletModel//; F
.//F G
Id//G I
}//J K
,//K L
outletModel00 
.00 (
ToOutletResponseDtofromModel00 4
(004 5
)005 6
)006 7
;007 8
}11 
[33 

HttpDelete33 
(33 
$str33 
)33 
]33 
public44 

async44 
Task44 
<44 
IActionResult44 #
>44# $
DeleteOutlet44% 1
(441 2
[442 3
	FromRoute443 <
]44< =
int44> A
id44B D
)44D E
{55 
try66 
{77 	
var88 
existingOutlet88 
=88  
await88! &
_outletRepo88' 2
.882 3
GetOutletByIdAsync883 E
(88E F
id88F H
)88H I
;88I J
if99 
(99 
existingOutlet99 
==99 !
null99" &
)99& '
return:: 
NotFound:: 
(::  
$str::  2
)::2 3
;::3 4
var<< 
result<< 
=<< 
await<< 
_outletRepo<< *
.<<* +
DeleteOutletAsync<<+ <
(<<< =
id<<= ?
)<<? @
;<<@ A
if== 
(== 
!== 
result== 
)== 
return>> 

StatusCode>> !
(>>! "
$num>>" %
,>>% &
$str>>' U
)>>U V
;>>V W
return@@ 
Ok@@ 
(@@ 
new@@ 
{@@ 
message@@ #
=@@$ %
$"@@& (
$str@@( 7
{@@7 8
id@@8 :
}@@: ;
$str@@; P
"@@P Q
}@@R S
)@@S T
;@@T U
}AA 	
catchBB 
(BB 
	ExceptionBB 
eBB 
)BB 
{CC 	
ConsoleDD 
.DD 
	WriteLineDD 
(DD 
eDD 
)DD  
;DD  !
returnEE 

StatusCodeEE 
(EE 
$numEE !
,EE! "
$strEE# Q
)EEQ R
;EER S
}FF 	
}GG 
}II Ï
M/Users/gayan/Developer/GasByGas/backend/Controllers/NotificationController.cs
	namespace 	
backend
 
. 
Controllers 
; 
[ 
ApiController 
] 
[ 
Route 
( 
$str 
) 
] 
public		 
class		 "
NotificationController		 #
:		# $
ControllerBase		% 3
{

 
private 
readonly 
ISmsService  
_smsService! ,
;, -
private 
readonly 
IMailService !
_mailService" .
;. /
public 
"
NotificationController !
(! "
ISmsService" -

smsService. 8
,8 9
IMailService: F
mailServiceG R
)R S
{ 
_smsService 
= 

smsService  
;  !
_mailService 
= 
mailService "
;" #
} 
[ 
HttpPost 
( 
$str 
) 
] 
public 

async 
Task 
< 
IActionResult #
># $
SendSms% ,
(, -
[- .
FromBody. 6
]6 7
SmsRequestDto8 E
smsRequestDtoF S
)S T
{ 
if 

(
 
! 

ModelState 
. 
IsValid 
) 
return  &

BadRequest' 1
(1 2

ModelState2 <
)< =
;= >
var 
status 
= 
await 
_smsService &
.& '
SendSmsAsync' 3
(3 4
smsRequestDto4 A
.A B
	RecepientB K
,K L
smsRequestDtoM Z
.Z [
Message[ b
)b c
;c d
if 

( 
status 
) 
return 
Ok 
( 
status $
)$ %
;% &
return 

BadRequest 
( 
$str 0
)0 1
;1 2
} 
[   
HttpPost   
(   
$str   
)   
]   
public!! 

async!! 
Task!! 
<!! 
IActionResult!! #
>!!# $
	SendEmail!!% .
(!!. /
[!!/ 0
FromBody!!0 8
]!!8 9
EmailRequestDto!!: I
emailRequestDto!!J Y
)!!Y Z
{"" 
if## 

(##
 
!## 

ModelState## 
.## 
IsValid## 
)## 
return##  &

BadRequest##' 1
(##1 2

ModelState##2 <
)##< =
;##= >
var%% 
result%% 
=%% 
await%% 
_mailService%% '
.%%' (
SendEmailAsync%%( 6
(%%6 7
emailRequestDto%%7 F
.%%F G
ToEmail%%G N
,%%N O
emailRequestDto%%P _
.%%_ `
ToName%%` f
,%%f g
emailRequestDto&& 
.&& 
Subject&& #
,&&# $
emailRequestDto&&% 4
.&&4 5
Body&&5 9
)&&9 :
;&&: ;
if'' 

(''
 
result'' 
)'' 
return'' 
Ok'' 
('' 
)'' 
;'' 
return(( 

BadRequest(( 
((( 
$str(( 0
)((0 1
;((1 2
})) 
},, ™@
I/Users/gayan/Developer/GasByGas/backend/Controllers/DeliveryController.cs
	namespace 	
backend
 
. 
Controllers 
; 
[ 
ApiController 
] 
[ 
Route 
( 
$str 
) 
] 
public		 
class		 
DeliveryController		 
:		  
ControllerBase		! /
{

 
private 
readonly 
IDeliveryRepository (
_deliveryRepository) <
;< =
private 
readonly 
IOutletRepository &
_outletRepository' 8
;8 9
public 

DeliveryController 
( 
IDeliveryRepository 1
deliveryRepository2 D
,D E
IOutletRepositoryF W
outletRepositoryX h
)h i
{ 
_deliveryRepository 
= 
deliveryRepository 0
;0 1
_outletRepository 
= 
outletRepository ,
;, -
} 
[ 
HttpPost 
] 
public 

async 
Task 
< 
IActionResult #
># $
Create% +
(+ ,
[, -
FromBody- 5
]5 6
DeliveryRequestDto7 I
requestJ Q
)Q R
{ 
if 

(
 
! 

ModelState 
. 
IsValid 
) 
return  &

BadRequest' 1
(1 2

ModelState2 <
)< =
;= >
var 
outlet 
= 
await 
_outletRepository ,
., -
OutletExists- 9
(9 :
request: A
.A B
OutletIdB J
)J K
;K L
if 

(
 
! 
outlet 
) 
return 
NotFound #
(# $
$str$ 6
)6 7
;7 8
var !
deliveryScheduleModel !
=" #
request$ +
.+ ,-
!DeliveryRequestDtoToDeliveryModel, M
(M N
)N O
;O P
await 
_deliveryRepository !
.! "
CreateAsync" -
(- .!
deliveryScheduleModel. C
)C D
;D E
return 
CreatedAtAction 
( 
nameof %
(% &
GetById& -
)- .
,. /
new0 3
{4 5
id6 8
=9 :!
deliveryScheduleModel; P
.P Q
IdQ S
}T U
,U V!
deliveryScheduleModelW l
.l m.
!DeliverySheduleModelToResponseDto	m é
(
é è
)
è ê
)
ê ë
;
ë í
}"" 
[$$ 
HttpGet$$ 
($$ 
$str$$ 
)$$ 
]$$ 
public%% 

async%% 
Task%% 
<%% 
IActionResult%% #
>%%# $
GetById%%% ,
(%%, -
[%%- .
	FromRoute%%. 7
]%%7 8
int%%9 <
id%%= ?
)%%? @
{&& 
var'' 
schedule'' 
='' 
await'' 
_deliveryRepository'' 0
.''0 1
GetById''1 8
(''8 9
id''9 ;
)''; <
;''< =
if(( 

(((
 
schedule(( 
==(( 
null(( 
)(( 
return(( #
NotFound(($ ,
(((, -
)((- .
;((. /
return)) 
Ok)) 
()) 
schedule)) 
.)) -
!DeliverySheduleModelToResponseDto)) <
())< =
)))= >
)))> ?
;))? @
}++ 
[-- 
HttpGet-- 
]-- 
public.. 

async.. 
Task.. 
<.. 
IActionResult.. #
>..# $
GetAll..% +
(..+ ,
).., -
{// 
var00 
	schedules00 
=00 
await00 
_deliveryRepository00 1
.001 2
GetAllAsync002 =
(00= >
)00> ?
;00? @
return11 
Ok11 
(11 
	schedules11 
.11 
Select11 "
(11" #
schedule11# +
=>11, .
schedule11/ 7
.117 8-
!DeliverySheduleModelToResponseDto118 Y
(11Y Z
)11Z [
)11[ \
)11\ ]
;11] ^
}22 
[44 
HttpPut44 
(44 
$str44 
)44 
]44 
public55 

async55 
Task55 
<55 
IActionResult55 #
>55# $
Update55% +
(55+ ,
[55, -
	FromRoute55- 6
]556 7
int558 ;
id55< >
,55> ?
[55@ A
FromBody55A I
]55I J
DeliveryRequestDto55K ]
request55^ e
)55e f
{66 
var77 
outlet77 
=77 
await77 
_outletRepository77 ,
.77, -
OutletExists77- 9
(779 :
request77: A
.77A B
OutletId77B J
)77J K
;77K L
if88 

(88
 
!88 
outlet88 
)88 
return88 
NotFound88 #
(88# $
$str88$ 6
)886 7
;887 8
var:: 
scheduleModel:: 
=:: 
await:: !
_deliveryRepository::" 5
.::5 6
UpdateAsync::6 A
(::A B
id::B D
,::D E
request::F M
)::M N
;::N O
if;; 

(;;
 
scheduleModel;; 
==;; 
null;;  
);;  !
return;;" (
NotFound;;) 1
(;;1 2
);;2 3
;;;3 4
return<< 
Ok<< 
(<< 
scheduleModel<< 
.<<  -
!DeliverySheduleModelToResponseDto<<  A
(<<A B
)<<B C
)<<C D
;<<D E
}== 
[?? 

HttpDelete?? 
(?? 
$str?? 
)?? 
]?? 
public@@ 

async@@ 
Task@@ 
<@@ 
IActionResult@@ #
>@@# $
Delete@@% +
(@@+ ,
[@@, -
	FromRoute@@- 6
]@@6 7
int@@8 ;
id@@< >
)@@> ?
{AA 
tryBB 
{CC 	
varDD 
existingScheduleDD  
=DD! "
awaitDD# (
_deliveryRepositoryDD) <
.DD< =
GetByIdDD= D
(DDD E
idDDE G
)DDG H
;DDH I
ifEE 
(EE 
existingScheduleEE  
==EE! #
nullEE$ (
)EE( )
returnFF 
NotFoundFF 
(FF  
$strFF  =
)FF= >
;FF> ?
varHH 
resultHH 
=HH 
awaitHH 
_deliveryRepositoryHH 2
.HH2 3
DeleteAsyncHH3 >
(HH> ?
idHH? A
)HHA B
;HHB C
ifII 
(II 
!II 
resultII 
)II 
returnJJ 

StatusCodeJJ !
(JJ! "
$numJJ" %
,JJ% &
$strJJ' `
)JJ` a
;JJa b
returnLL 
OkLL 
(LL 
newLL 
{LL 
messageLL #
=LL$ %
$"LL& (
$strLL( B
{LLB C
idLLC E
}LLE F
$strLLF [
"LL[ \
}LL] ^
)LL^ _
;LL_ `
}MM 	
catchNN 
(NN 
	ExceptionNN 
eNN 
)NN 
{OO 	
ConsolePP 
.PP 
	WriteLinePP 
(PP 
ePP 
)PP  
;PP  !
returnQQ 

StatusCodeQQ 
(QQ 
$numQQ !
,QQ! "
$strQQ# \
)QQ\ ]
;QQ] ^
}RR 	
}SS 
}UU Ãˇ
H/Users/gayan/Developer/GasByGas/backend/Controllers/AccountController.cs
	namespace 	
backend
 
. 
Controllers 
; 
[ 
ApiController 
] 
[ 
Route 
( 
$str 
) 
] 
public 
class 
AccountController 
:  
ControllerBase! /
{ 
private 
readonly 
UserManager  
<  !
AppUser! (
>( )
_userManager* 6
;6 7
private 
readonly 
ITokenService "
_tokenService# 0
;0 1
private 
readonly 
SignInManager "
<" #
AppUser# *
>* +
_signInManager, :
;: ;
private 
readonly 
IOutletRepository &
_outletRepository' 8
;8 9
private 
readonly 
IAccountRepository '
_accountRepo( 4
;4 5
const 	
int
 #
NO_OF_CYLINDERS_ALLOWED %
=& '
$num( )
;) *
public 

AccountController 
( 
UserManager (
<( )
AppUser) 0
>0 1
userManager2 =
,= >
ITokenService? L
tokenServiceM Y
,Y Z
SignInManager[ h
<h i
AppUseri p
>p q
signInManagerr 
,	 Ä
IOutletRepository
Å í
outletRepository
ì £
,
£ § 
IAccountRepository
• ∑
accountRepo
∏ √
)
√ ƒ
{ 
_userManager 
= 
userManager "
;" #
_tokenService 
= 
tokenService $
;$ %
_signInManager 
= 
signInManager &
;& '
_outletRepository 
= 
outletRepository ,
;, -
_accountRepo 
= 
accountRepo "
;" #
}   
[## 
HttpGet## 
(## 
$str## %
)##% &
]##& '
public$$ 

async$$ 
Task$$ 
<$$ 
IActionResult$$ #
>$$# $
GetManagers$$% 0
($$0 1
int$$1 4
outletId$$5 =
)$$= >
{%% 
var&& 
outlet&& 
=&& 
await&& 
_outletRepository&& ,
.&&, -
OutletExists&&- 9
(&&9 :
outletId&&: B
)&&B C
;&&C D
if'' 

('' 
outlet'' 
=='' 
null'' 
)'' 
{(( 	
return)) 
NotFound)) 
()) 
$str)) .
))). /
;))/ 0
}** 	
var-- 
managers-- 
=-- 
await-- 
_accountRepo-- )
.--) *&
GetManagersByOutletIdAsync--* D
(--D E
outletId--E M
)--M N
;--N O
if.. 

(.. 
!.. 
managers.. 
... 
Any.. 
(.. 
).. 
).. 
{// 	
return00 
	NoContent00 
(00 
)00 
;00 
}11 	
var22 
managerReponseDtos22 
=22  
managers22! )
.22) *
Select22* 0
(220 1
s221 2
=>223 5
s226 7
.227 8
ToManagerReponseDto228 K
(22K L
)22L M
)22M N
;22N O
return33 
Ok33 
(33 
managerReponseDtos33 $
)33$ %
;33% &
}44 
[66 
HttpGet66 
(66 
$str66 
)66 
]66 
public77 

async77 
Task77 
<77 
IActionResult77 #
>77# $
GetConsumers77% 1
(771 2
)772 3
{88 
var99 
	consumers99 
=99 
await99 
_accountRepo99 *
.99* +
GetConsumersAsync99+ <
(99< =
)99= >
;99> ?
if:: 

(:: 
!:: 
	consumers:: 
.:: 
Any:: 
(:: 
):: 
):: 
{;; 	
return<< 
	NoContent<< 
(<< 
)<< 
;<< 
}== 	
var?? 
consumerReponseDtos?? 
=??  !
	consumers??" +
.??+ ,
Select??, 2
(??2 3
s??3 4
=>??5 7
s??8 9
.??9 :!
ToConsumerResponseDto??: O
(??O P
)??P Q
)??Q R
;??R S
return@@ 
Ok@@ 
(@@ 
consumerReponseDtos@@ %
)@@% &
;@@& '
}AA 
[DD 
HttpPostDD 
(DD 
$strDD 
)DD 
]DD 
publicEE 

asyncEE 
TaskEE 
<EE 
IActionResultEE #
>EE# $
RegisterEE% -
(EE- .
[EE. /
FromBodyEE/ 7
]EE7 8"
UserRegisterRequestDtoEE9 O

requestDtoEEP Z
)EEZ [
{FF 
tryGG 
{HH 	
ifII 
(II 
!II 

ModelStateII 
.II 
IsValidII "
)II" #
returnJJ 

BadRequestJJ !
(JJ! "

ModelStateJJ" ,
)JJ, -
;JJ- .
NewUserResponseDtoNN 
responseDtoNN *
=NN+ ,
nullNN- 1
;NN1 2
ifOO 
(OO 

requestDtoOO 
.OO 
UserTypeOO #
==OO$ &
UserTypeOO' /
.OO/ 0
AdminOO0 5
)OO5 6
{PP 
varQQ 
appUserQQ 
=QQ 
newQQ !
AppUserQQ" )
{RR 
EmailSS 
=SS 

requestDtoSS &
.SS& '
EmailSS' ,
,SS, -
UserNameTT 
=TT 

requestDtoTT )
.TT) *
EmailTT* /
,TT/ 0
FullNameUU 
=UU 

requestDtoUU )
.UU) *
FullNameUU* 2
,UU2 3
PhoneNumberVV 
=VV  !

requestDtoVV" ,
.VV, -
PhoneNumberVV- 8
,VV8 9
ConsumerTypeWW  
=WW! "

requestDtoWW# -
.WW- .
UserTypeWW. 6
,WW6 7
	IsConfirmXX 
=XX 
trueXX  $
,XX$ %
}YY 
;YY 
var[[ 
createdUser[[ 
=[[  !
await[[" '
_userManager[[( 4
.[[4 5
CreateAsync[[5 @
([[@ A
appUser[[A H
,[[H I

requestDto[[J T
.[[T U
Password[[U ]
)[[] ^
;[[^ _
if\\ 
(\\ 
createdUser\\ 
.\\  
	Succeeded\\  )
)\\) *
{]] 
var__ 

roleResult__ "
=__# $
await__% *
_userManager__+ 7
.__7 8
AddToRoleAsync__8 F
(__F G
appUser__G N
,__N O
$str__P W
)__W X
;__X Y
if`` 
(`` 

roleResult`` "
.``" #
	Succeeded``# ,
)``, -
{aa 
responseDtobb #
=bb$ %
newbb& )
NewUserResponseDtobb* <
{cc 
Emaildd !
=dd" #
appUserdd$ +
.dd+ ,
Emaildd, 1
,dd1 2
FullNameee $
=ee% &
appUseree' .
.ee. /
FullNameee/ 7
,ee7 8
PhoneNumberff '
=ff( )
appUserff* 1
.ff1 2
PhoneNumberff2 =
,ff= >
	IsConfirmgg %
=gg& '
appUsergg( /
.gg/ 0
	IsConfirmgg0 9
,gg9 :
UserTypehh $
=hh% &
appUserhh' .
.hh. /
ConsumerTypehh/ ;
??hh< >
UserTypehh? G
.hhG H
PersonalhhH P
,hhP Q
Tokenii !
=ii" #
awaitii$ )
_tokenServiceii* 7
.ii7 8
CreateTokenii8 C
(iiC D
appUseriiD K
)iiK L
}jj 
;jj 
}kk 
elsell 
{mm 
returnnn 

StatusCodenn )
(nn) *
$numnn* -
,nn- .

roleResultnn/ 9
.nn9 :
Errorsnn: @
)nn@ A
;nnA B
}oo 
}pp 
elseqq 
{rr 
returnss 

StatusCodess %
(ss% &
$numss& )
,ss) *
createdUserss+ 6
.ss6 7
Errorsss7 =
)ss= >
;ss> ?
}tt 
}vv 
elseyy 
ifyy 
(yy 

requestDtoyy 
.yy  
UserTypeyy  (
==yy) +
UserTypeyy, 4
.yy4 5
Manageryy5 <
)yy< =
{zz 
if{{ 
({{ 

requestDto{{ 
.{{ 
OutletId{{ '
=={{( *
null{{+ /
){{/ 0
{|| 
return}} 

BadRequest}} %
(}}% &
$str}}& N
)}}N O
;}}O P
}~~ 
if
ÄÄ 
(
ÄÄ 
!
ÄÄ 
await
ÄÄ 
_outletRepository
ÄÄ ,
.
ÄÄ, -
OutletExists
ÄÄ- 9
(
ÄÄ9 :
(
ÄÄ: ;
int
ÄÄ; >
)
ÄÄ> ?

requestDto
ÄÄ? I
.
ÄÄI J
OutletId
ÄÄJ R
)
ÄÄR S
)
ÄÄS T
{
ÅÅ 
return
ÇÇ 

BadRequest
ÇÇ %
(
ÇÇ% &
$str
ÇÇ& =
)
ÇÇ= >
;
ÇÇ> ?
}
ÉÉ 
var
ÖÖ 
appUser
ÖÖ 
=
ÖÖ 
new
ÖÖ !
AppUser
ÖÖ" )
{
ÜÜ 
Email
áá 
=
áá 

requestDto
áá &
.
áá& '
Email
áá' ,
,
áá, -
UserName
àà 
=
àà 

requestDto
àà )
.
àà) *
Email
àà* /
,
àà/ 0
FullName
ââ 
=
ââ 

requestDto
ââ )
.
ââ) *
FullName
ââ* 2
,
ââ2 3
PhoneNumber
ää 
=
ää  !

requestDto
ää" ,
.
ää, -
PhoneNumber
ää- 8
,
ää8 9
ConsumerType
ãã  
=
ãã! "

requestDto
ãã# -
.
ãã- .
UserType
ãã. 6
,
ãã6 7
	IsConfirm
åå 
=
åå 
true
åå  $
,
åå$ %
OutletId
çç 
=
çç 

requestDto
çç )
.
çç) *
OutletId
çç* 2
}
éé 
;
éé 
var
êê 
createdUser
êê 
=
êê  !
await
êê" '
_userManager
êê( 4
.
êê4 5
CreateAsync
êê5 @
(
êê@ A
appUser
êêA H
,
êêH I

requestDto
êêJ T
.
êêT U
Password
êêU ]
)
êê] ^
;
êê^ _
if
ëë 
(
ëë 
createdUser
ëë 
.
ëë  
	Succeeded
ëë  )
)
ëë) *
{
íí 
var
îî 

roleResult
îî "
=
îî# $
await
îî% *
_userManager
îî+ 7
.
îî7 8
AddToRoleAsync
îî8 F
(
îîF G
appUser
îîG N
,
îîN O
$str
îîP Y
)
îîY Z
;
îîZ [
if
ïï 
(
ïï 

roleResult
ïï "
.
ïï" #
	Succeeded
ïï# ,
)
ïï, -
{
ññ 
responseDto
òò #
=
òò$ %
new
òò& ) 
NewUserResponseDto
òò* <
{
ôô 
Email
öö !
=
öö" #
appUser
öö$ +
.
öö+ ,
Email
öö, 1
,
öö1 2
FullName
õõ $
=
õõ% &
appUser
õõ' .
.
õõ. /
FullName
õõ/ 7
,
õõ7 8
OutletId
úú $
=
úú% &
appUser
úú' .
.
úú. /
OutletId
úú/ 7
,
úú7 8
PhoneNumber
ùù '
=
ùù( )
appUser
ùù* 1
.
ùù1 2
PhoneNumber
ùù2 =
,
ùù= >
	IsConfirm
ûû %
=
ûû& '
appUser
ûû( /
.
ûû/ 0
	IsConfirm
ûû0 9
,
ûû9 :
UserType
üü $
=
üü% &
appUser
üü' .
.
üü. /
ConsumerType
üü/ ;
??
üü< >
UserType
üü? G
.
üüG H
Personal
üüH P
,
üüP Q
Token
†† !
=
††" #
await
††$ )
_tokenService
††* 7
.
††7 8
CreateToken
††8 C
(
††C D
appUser
††D K
)
††K L
}
°° 
;
°° 
}
££ 
else
§§ 
{
•• 
return
¶¶ 

StatusCode
¶¶ )
(
¶¶) *
$num
¶¶* -
,
¶¶- .

roleResult
¶¶/ 9
.
¶¶9 :
Errors
¶¶: @
)
¶¶@ A
;
¶¶A B
}
ßß 
}
®® 
else
©© 
{
™™ 
return
´´ 

StatusCode
´´ %
(
´´% &
$num
´´& )
,
´´) *
createdUser
´´+ 6
.
´´6 7
Errors
´´7 =
)
´´= >
;
´´> ?
}
¨¨ 
}
ÆÆ 
else
±± 
if
±± 
(
±± 

requestDto
±± 
.
±±  
UserType
±±  (
==
±±) +
UserType
±±, 4
.
±±4 5
Personal
±±5 =
)
±±= >
{
≤≤ 
if
≥≥ 
(
≥≥ 

requestDto
≥≥ 
.
≥≥ 
NIC
≥≥ "
==
≥≥# %
null
≥≥& *
)
≥≥* +
{
¥¥ 
return
µµ 

BadRequest
µµ %
(
µµ% &
$str
µµ& L
)
µµL M
;
µµM N
}
∂∂ 
if
∏∏ 
(
∏∏ 

requestDto
∏∏ 
.
∏∏ 
City
∏∏ #
==
∏∏$ &
null
∏∏' +
||
∏∏, .

requestDto
∏∏/ 9
.
∏∏9 :
Address
∏∏: A
==
∏∏B D
null
∏∏E I
)
∏∏I J
{
ππ 
return
∫∫ 

BadRequest
∫∫ %
(
∫∫% &
$str
∫∫& Y
)
∫∫Y Z
;
∫∫Z [
}
ªª 
var
ΩΩ 
appUser
ΩΩ 
=
ΩΩ 
new
ΩΩ !
AppUser
ΩΩ" )
{
ææ 
Email
øø 
=
øø 

requestDto
øø &
.
øø& '
Email
øø' ,
,
øø, -
UserName
¿¿ 
=
¿¿ 

requestDto
¿¿ )
.
¿¿) *
Email
¿¿* /
,
¿¿/ 0
FullName
¡¡ 
=
¡¡ 

requestDto
¡¡ )
.
¡¡) *
FullName
¡¡* 2
,
¡¡2 3
Nic
¬¬ 
=
¬¬ 

requestDto
¬¬ $
.
¬¬$ %
NIC
¬¬% (
,
¬¬( )
PhoneNumber
√√ 
=
√√  !

requestDto
√√" ,
.
√√, -
PhoneNumber
√√- 8
,
√√8 9
Address
ƒƒ 
=
ƒƒ 

requestDto
ƒƒ (
.
ƒƒ( )
Address
ƒƒ) 0
,
ƒƒ0 1
City
≈≈ 
=
≈≈ 

requestDto
≈≈ %
.
≈≈% &
City
≈≈& *
,
≈≈* +
ConsumerType
∆∆  
=
∆∆! "

requestDto
∆∆# -
.
∆∆- .
UserType
∆∆. 6
,
∆∆6 7
	IsConfirm
«« 
=
«« 
true
««  $
,
««$ %"
NoOfCylindersAllowed
»» (
=
»») *%
NO_OF_CYLINDERS_ALLOWED
»»+ B
,
»»B C'
RemainingCylindersAllowed
…… -
=
……. /%
NO_OF_CYLINDERS_ALLOWED
……0 G
}
   
;
   
var
ÕÕ 
createdUser
ÕÕ 
=
ÕÕ  !
await
ÕÕ" '
_userManager
ÕÕ( 4
.
ÕÕ4 5
CreateAsync
ÕÕ5 @
(
ÕÕ@ A
appUser
ÕÕA H
,
ÕÕH I

requestDto
ÕÕJ T
.
ÕÕT U
Password
ÕÕU ]
)
ÕÕ] ^
;
ÕÕ^ _
if
ŒŒ 
(
ŒŒ 
createdUser
ŒŒ 
.
ŒŒ  
	Succeeded
ŒŒ  )
)
ŒŒ) *
{
œœ 
var
—— 

roleResult
—— "
=
——# $
await
——% *
_userManager
——+ 7
.
——7 8
AddToRoleAsync
——8 F
(
——F G
appUser
——G N
,
——N O
$str
——P V
)
——V W
;
——W X
if
““ 
(
““ 

roleResult
““ "
.
““" #
	Succeeded
““# ,
)
““, -
{
”” 
responseDto
’’ #
=
’’$ %
new
’’& ) 
NewUserResponseDto
’’* <
{
÷÷ 
Email
◊◊ !
=
◊◊" #
appUser
◊◊$ +
.
◊◊+ ,
Email
◊◊, 1
,
◊◊1 2
FullName
ÿÿ $
=
ÿÿ% &
appUser
ÿÿ' .
.
ÿÿ. /
FullName
ÿÿ/ 7
,
ÿÿ7 8
NIC
ŸŸ 
=
ŸŸ  !
appUser
ŸŸ" )
.
ŸŸ) *
Nic
ŸŸ* -
,
ŸŸ- .
PhoneNumber
⁄⁄ '
=
⁄⁄( )
appUser
⁄⁄* 1
.
⁄⁄1 2
PhoneNumber
⁄⁄2 =
,
⁄⁄= >
Address
€€ #
=
€€$ %
appUser
€€& -
.
€€- .
Address
€€. 5
,
€€5 6
City
‹‹  
=
‹‹! "
appUser
‹‹# *
.
‹‹* +
City
‹‹+ /
,
‹‹/ 0
	IsConfirm
›› %
=
››& '
appUser
››( /
.
››/ 0
	IsConfirm
››0 9
,
››9 :"
NoOfCylindersAllowed
ﬁﬁ 0
=
ﬁﬁ1 2
appUser
ﬁﬁ3 :
.
ﬁﬁ: ;"
NoOfCylindersAllowed
ﬁﬁ; O
,
ﬁﬁO P'
RemainingCylindersAllowed
ﬂﬂ 5
=
ﬂﬂ6 7
appUser
ﬂﬂ8 ?
.
ﬂﬂ? @'
RemainingCylindersAllowed
ﬂﬂ@ Y
,
ﬂﬂY Z
UserType
‡‡ $
=
‡‡% &
appUser
‡‡' .
.
‡‡. /
ConsumerType
‡‡/ ;
??
‡‡< >
UserType
‡‡? G
.
‡‡G H
Personal
‡‡H P
,
‡‡P Q
Token
·· !
=
··" #
await
··$ )
_tokenService
··* 7
.
··7 8
CreateToken
··8 C
(
··C D
appUser
··D K
)
··K L
}
‚‚ 
;
‚‚ 
}
‰‰ 
else
ÂÂ 
{
ÊÊ 
return
ÁÁ 

StatusCode
ÁÁ )
(
ÁÁ) *
$num
ÁÁ* -
,
ÁÁ- .

roleResult
ÁÁ/ 9
.
ÁÁ9 :
Errors
ÁÁ: @
)
ÁÁ@ A
;
ÁÁA B
}
ËË 
}
ÈÈ 
else
ÍÍ 
{
ÎÎ 
return
ÏÏ 

StatusCode
ÏÏ %
(
ÏÏ% &
$num
ÏÏ& )
,
ÏÏ) *
createdUser
ÏÏ+ 6
.
ÏÏ6 7
Errors
ÏÏ7 =
)
ÏÏ= >
;
ÏÏ> ?
}
ÌÌ 
}
ÔÔ 
else
ÚÚ 
if
ÚÚ 
(
ÚÚ 

requestDto
ÚÚ 
.
ÚÚ  
UserType
ÚÚ  (
==
ÚÚ) +
UserType
ÚÚ, 4
.
ÚÚ4 5
Business
ÚÚ5 =
||
ÚÚ> @

requestDto
ÚÚA K
.
ÚÚK L
UserType
ÚÚL T
==
ÚÚU W
UserType
ÚÚX `
.
ÚÚ` a

Industries
ÚÚa k
)
ÚÚk l
{
ÛÛ 
if
ıı 
(
ıı 

requestDto
ıı 
.
ıı 
City
ıı #
==
ıı$ &
null
ıı' +
||
ıı, .

requestDto
ıı/ 9
.
ıı9 :
Address
ıı: A
==
ııB D
null
ııE I
)
ııI J
{
ˆˆ 
return
˜˜ 

BadRequest
˜˜ %
(
˜˜% &
$str
˜˜& Y
)
˜˜Y Z
;
˜˜Z [
}
¯¯ 
if
˙˙ 
(
˙˙ 

requestDto
˙˙ 
.
˙˙ "
BusinessRegistration
˙˙ 3
==
˙˙4 6
null
˙˙7 ;
)
˙˙; <
{
˚˚ 
return
¸¸ 

BadRequest
¸¸ %
(
¸¸% &
$str
¸¸& c
)
¸¸c d
;
¸¸d e
}
˝˝ 
if
ˇˇ 
(
ˇˇ 

requestDto
ˇˇ 
.
ˇˇ "
NoOfCylindersAllowed
ˇˇ 3
==
ˇˇ4 6
null
ˇˇ7 ;
)
ˇˇ; <
{
ÄÄ 
return
ÅÅ 

BadRequest
ÅÅ %
(
ÅÅ% &
$str
ÅÅ& ^
)
ÅÅ^ _
;
ÅÅ_ `
}
ÇÇ 
var
ÑÑ 
appUser
ÑÑ 
=
ÑÑ 
new
ÑÑ !
AppUser
ÑÑ" )
{
ÖÖ 
Email
ÜÜ 
=
ÜÜ 

requestDto
ÜÜ &
.
ÜÜ& '
Email
ÜÜ' ,
,
ÜÜ, -
UserName
áá 
=
áá 

requestDto
áá )
.
áá) *
Email
áá* /
,
áá/ 0
FullName
àà 
=
àà 

requestDto
àà )
.
àà) *
FullName
àà* 2
,
àà2 3"
BusinessRegistration
ââ (
=
ââ) *

requestDto
ââ+ 5
.
ââ5 6"
BusinessRegistration
ââ6 J
,
ââJ K
PhoneNumber
ää 
=
ää  !

requestDto
ää" ,
.
ää, -
PhoneNumber
ää- 8
,
ää8 9
Address
ãã 
=
ãã 

requestDto
ãã (
.
ãã( )
Address
ãã) 0
,
ãã0 1
City
åå 
=
åå 

requestDto
åå %
.
åå% &
City
åå& *
,
åå* +
ConsumerType
çç  
=
çç! "

requestDto
çç# -
.
çç- .
UserType
çç. 6
,
çç6 7
	IsConfirm
éé 
=
éé 
false
éé  %
,
éé% &"
NoOfCylindersAllowed
èè (
=
èè) *

requestDto
èè+ 5
.
èè5 6"
NoOfCylindersAllowed
èè6 J
,
èèJ K'
RemainingCylindersAllowed
êê -
=
êê. /

requestDto
êê0 :
.
êê: ;"
NoOfCylindersAllowed
êê; O
}
ëë 
;
ëë 
var
ìì 
createdUser
ìì 
=
ìì  !
await
ìì" '
_userManager
ìì( 4
.
ìì4 5
CreateAsync
ìì5 @
(
ìì@ A
appUser
ììA H
,
ììH I

requestDto
ììJ T
.
ììT U
Password
ììU ]
)
ìì] ^
;
ìì^ _
if
îî 
(
îî 
createdUser
îî 
.
îî  
	Succeeded
îî  )
)
îî) *
{
ïï 
var
óó 

roleResult
óó "
=
óó# $
await
óó% *
_userManager
óó+ 7
.
óó7 8
AddToRoleAsync
óó8 F
(
óóF G
appUser
óóG N
,
óóN O
$str
óóP V
)
óóV W
;
óóW X
if
òò 
(
òò 

roleResult
òò "
.
òò" #
	Succeeded
òò# ,
)
òò, -
{
ôô 
responseDto
õõ #
=
õõ$ %
new
õõ& ) 
NewUserResponseDto
õõ* <
{
úú 
Email
ùù !
=
ùù" #
appUser
ùù$ +
.
ùù+ ,
Email
ùù, 1
,
ùù1 2
FullName
ûû $
=
ûû% &
appUser
ûû' .
.
ûû. /
FullName
ûû/ 7
,
ûû7 8"
BusinessRegistration
üü 0
=
üü1 2
appUser
üü3 :
.
üü: ;"
BusinessRegistration
üü; O
,
üüO P
PhoneNumber
†† '
=
††( )
appUser
††* 1
.
††1 2
PhoneNumber
††2 =
,
††= >
Address
°° #
=
°°$ %
appUser
°°& -
.
°°- .
Address
°°. 5
,
°°5 6
City
¢¢  
=
¢¢! "
appUser
¢¢# *
.
¢¢* +
City
¢¢+ /
,
¢¢/ 0
	IsConfirm
££ %
=
££& '
appUser
££( /
.
££/ 0
	IsConfirm
££0 9
,
££9 :
UserType
§§ $
=
§§% &
appUser
§§' .
.
§§. /
ConsumerType
§§/ ;
??
§§< >
UserType
§§? G
.
§§G H
Personal
§§H P
,
§§P Q"
NoOfCylindersAllowed
•• 0
=
••1 2
appUser
••3 :
.
••: ;"
NoOfCylindersAllowed
••; O
,
••O P'
RemainingCylindersAllowed
¶¶ 5
=
¶¶6 7
appUser
¶¶8 ?
.
¶¶? @'
RemainingCylindersAllowed
¶¶@ Y
,
¶¶Y Z
Token
ßß !
=
ßß" #
await
ßß$ )
_tokenService
ßß* 7
.
ßß7 8
CreateToken
ßß8 C
(
ßßC D
appUser
ßßD K
)
ßßK L
}
®® 
;
®® 
}
™™ 
else
´´ 
{
¨¨ 
return
≠≠ 

StatusCode
≠≠ )
(
≠≠) *
$num
≠≠* -
,
≠≠- .

roleResult
≠≠/ 9
.
≠≠9 :
Errors
≠≠: @
)
≠≠@ A
;
≠≠A B
}
ÆÆ 
}
ØØ 
else
∞∞ 
{
±± 
return
≤≤ 

StatusCode
≤≤ %
(
≤≤% &
$num
≤≤& )
,
≤≤) *
createdUser
≤≤+ 6
.
≤≤6 7
Errors
≤≤7 =
)
≤≤= >
;
≤≤> ?
}
≥≥ 
}
µµ 
if
∂∂ 
(
∂∂ 
responseDto
∂∂ 
==
∂∂ 
null
∂∂ #
)
∂∂# $
{
∂∂$ %
return
∂∂% +

BadRequest
∂∂, 6
(
∂∂6 7
$str
∂∂7 M
)
∂∂M N
;
∂∂N O
}
∂∂O P
return
∑∑ 
Ok
∑∑ 
(
∑∑ 
responseDto
∑∑ !
)
∑∑! "
;
∑∑" #
}
∏∏ 	
catch
ππ 
(
ππ 
	Exception
ππ 
e
ππ 
)
ππ 
{
∫∫ 	
Console
ªª 
.
ªª 
	WriteLine
ªª 
(
ªª 
e
ªª 
)
ªª  
;
ªª  !
return
ºº 

StatusCode
ºº 
(
ºº 
$num
ºº !
,
ºº! "
e
ºº# $
.
ºº$ %
Message
ºº% ,
)
ºº, -
;
ºº- .
}
ΩΩ 	
}
ææ 
[
¬¬ 
HttpPost
¬¬ 
(
¬¬ 
$str
¬¬ 
)
¬¬ 
]
¬¬ 
public
√√ 

async
√√ 
Task
√√ 
<
√√ 
IActionResult
√√ #
>
√√# $
Login
√√% *
(
√√* +
LoginDto
√√+ 3
loginDto
√√4 <
)
√√< =
{
ƒƒ 
if
≈≈ 

(
≈≈
 
!
≈≈ 

ModelState
≈≈ 
.
≈≈ 
IsValid
≈≈ 
)
≈≈ 
return
∆∆ 

BadRequest
∆∆ 
(
∆∆ 

ModelState
∆∆ (
)
∆∆( )
;
∆∆) *
var
»» 
user
»» 
=
»» 
await
»» 
_userManager
»» %
.
»»% &
Users
»»& +
.
»»+ ,!
FirstOrDefaultAsync
»», ?
(
»»? @
user
»»@ D
=>
»»E G
user
»»H L
.
»»L M
Email
»»M R
==
»»S U
loginDto
»»V ^
.
»»^ _
Email
»»_ d
)
»»d e
;
»»e f
if
…… 

(
……
 
user
…… 
==
…… 
null
…… 
)
…… 
return
   
Unauthorized
   
(
    
$str
    5
)
  5 6
;
  6 7
var
ÃÃ 
result
ÃÃ 
=
ÃÃ 
await
ÃÃ 
_signInManager
ÃÃ )
.
ÃÃ) *&
CheckPasswordSignInAsync
ÃÃ* B
(
ÃÃB C
user
ÃÃC G
,
ÃÃG H
loginDto
ÃÃI Q
.
ÃÃQ R
Password
ÃÃR Z
,
ÃÃZ [
false
ÃÃ\ a
)
ÃÃa b
;
ÃÃb c
if
ÕÕ 

(
ÕÕ
 
!
ÕÕ 
result
ÕÕ 
.
ÕÕ 
	Succeeded
ÕÕ 
)
ÕÕ 
return
ŒŒ 
Unauthorized
ŒŒ 
(
ŒŒ  
$str
ŒŒ  6
)
ŒŒ6 7
;
ŒŒ7 8
return
–– 
Ok
–– 
(
–– 
new
––  
NewUserResponseDto
–– (
{
—— 	
Email
““ 
=
““ 
user
““ 
.
““ 
Email
““ 
??
““ !
throw
““" '
new
““( +'
InvalidOperationException
““, E
(
““E F
)
““F G
,
““G H
FullName
”” 
=
”” 
user
”” 
.
”” 
FullName
”” $
??
””% '
throw
””( -
new
””. 1'
InvalidOperationException
””2 K
(
””K L
)
””L M
,
””M N
NIC
‘‘ 
=
‘‘ 
user
‘‘ 
.
‘‘ 
Nic
‘‘ 
,
‘‘ "
BusinessRegistration
’’  
=
’’! "
user
’’# '
.
’’' ("
BusinessRegistration
’’( <
,
’’< =
	IsConfirm
÷÷ 
=
÷÷ 
user
÷÷ 
.
÷÷ 
	IsConfirm
÷÷ &
,
÷÷& '
OutletId
◊◊ 
=
◊◊ 
user
◊◊ 
.
◊◊ 
OutletId
◊◊ $
,
◊◊$ %
PhoneNumber
ÿÿ 
=
ÿÿ 
user
ÿÿ 
.
ÿÿ 
PhoneNumber
ÿÿ *
??
ÿÿ+ -
throw
ÿÿ. 3
new
ÿÿ4 7'
InvalidOperationException
ÿÿ8 Q
(
ÿÿQ R
)
ÿÿR S
,
ÿÿS T
Address
ŸŸ 
=
ŸŸ 
user
ŸŸ 
.
ŸŸ 
Address
ŸŸ "
,
ŸŸ" #
City
⁄⁄ 
=
⁄⁄ 
user
⁄⁄ 
.
⁄⁄ 
City
⁄⁄ 
,
⁄⁄ '
RemainingCylindersAllowed
€€ %
=
€€& '
user
€€( ,
.
€€, -'
RemainingCylindersAllowed
€€- F
,
€€F G"
NoOfCylindersAllowed
‹‹  
=
‹‹! "
user
‹‹# '
.
‹‹' ("
NoOfCylindersAllowed
‹‹( <
,
‹‹< =
UserType
›› 
=
›› 
user
›› 
.
›› 
ConsumerType
›› (
??
››) +
UserType
››, 4
.
››4 5
Personal
››5 =
,
››= >
Token
ﬁﬁ 
=
ﬁﬁ 
await
ﬁﬁ 
_tokenService
ﬁﬁ '
.
ﬁﬁ' (
CreateToken
ﬁﬁ( 3
(
ﬁﬁ3 4
user
ﬁﬁ4 8
)
ﬁﬁ8 9
}
ﬂﬂ 	
)
ﬂﬂ	 

;
ﬂﬂ
 
}
‡‡ 
[
‚‚ 
HttpPut
‚‚ 
(
‚‚ 
$str
‚‚ 
)
‚‚ 
]
‚‚ 
public
„„ 

async
„„ 
Task
„„ 
<
„„ 
IActionResult
„„ #
>
„„# $

UpdateUser
„„% /
(
„„/ 0
[
„„0 1
	FromRoute
„„1 :
]
„„: ;
string
„„< B
email
„„C H
,
„„H I
[
„„J K
FromBody
„„K S
]
„„S T
UpdateUserDto
„„U b
updateUserDto
„„c p
)
„„p q
{
‰‰ 
try
ÂÂ 
{
ÊÊ 	
if
ÁÁ 
(
ÁÁ 
!
ÁÁ 

ModelState
ÁÁ 
.
ÁÁ 
IsValid
ÁÁ #
)
ÁÁ# $
return
ËË 

BadRequest
ËË !
(
ËË! "

ModelState
ËË" ,
)
ËË, -
;
ËË- .
var
ÍÍ 
user
ÍÍ 
=
ÍÍ 
await
ÍÍ 
_userManager
ÍÍ )
.
ÍÍ) *
FindByEmailAsync
ÍÍ* :
(
ÍÍ: ;
email
ÍÍ; @
)
ÍÍ@ A
;
ÍÍA B
if
ÎÎ 
(
ÎÎ 
user
ÎÎ 
==
ÎÎ 
null
ÎÎ 
)
ÎÎ 
return
ÏÏ 
NotFound
ÏÏ 
(
ÏÏ  
$str
ÏÏ  0
)
ÏÏ0 1
;
ÏÏ1 2
user
ÔÔ 
.
ÔÔ 
Email
ÔÔ 
=
ÔÔ 
updateUserDto
ÔÔ &
.
ÔÔ& '
Email
ÔÔ' ,
??
ÔÔ- /
user
ÔÔ0 4
.
ÔÔ4 5
Email
ÔÔ5 :
;
ÔÔ: ;
user
 
.
 
UserName
 
=
 
updateUserDto
 )
.
) *
Email
* /
??
0 2
user
3 7
.
7 8
UserName
8 @
;
@ A
user
ÒÒ 
.
ÒÒ 
FullName
ÒÒ 
=
ÒÒ 
updateUserDto
ÒÒ )
.
ÒÒ) *
FullName
ÒÒ* 2
??
ÒÒ3 5
user
ÒÒ6 :
.
ÒÒ: ;
FullName
ÒÒ; C
;
ÒÒC D
user
ÚÚ 
.
ÚÚ 
PhoneNumber
ÚÚ 
=
ÚÚ 
updateUserDto
ÚÚ ,
.
ÚÚ, -
PhoneNumber
ÚÚ- 8
??
ÚÚ9 ;
user
ÚÚ< @
.
ÚÚ@ A
PhoneNumber
ÚÚA L
;
ÚÚL M
if
ÙÙ 
(
ÙÙ 
updateUserDto
ÙÙ 
.
ÙÙ 
ConsumerType
ÙÙ *
==
ÙÙ+ -
UserType
ÙÙ. 6
.
ÙÙ6 7
Personal
ÙÙ7 ?
)
ÙÙ? @
{
ıı 
user
ˆˆ 
.
ˆˆ 
Nic
ˆˆ 
=
ˆˆ 
updateUserDto
ˆˆ (
.
ˆˆ( )
NIC
ˆˆ) ,
??
ˆˆ- /
user
ˆˆ0 4
.
ˆˆ4 5
Nic
ˆˆ5 8
;
ˆˆ8 9
user
˜˜ 
.
˜˜ 
City
˜˜ 
=
˜˜ 
updateUserDto
˜˜ )
.
˜˜) *
City
˜˜* .
??
˜˜/ 1
user
˜˜2 6
.
˜˜6 7
City
˜˜7 ;
;
˜˜; <
user
¯¯ 
.
¯¯ 
Address
¯¯ 
=
¯¯ 
updateUserDto
¯¯ ,
.
¯¯, -
Address
¯¯- 4
??
¯¯5 7
user
¯¯8 <
.
¯¯< =
Address
¯¯= D
;
¯¯D E
}
˙˙ 
if
¸¸ 
(
¸¸ 
updateUserDto
¸¸ 
.
¸¸ 
ConsumerType
¸¸ *
==
¸¸+ -
UserType
¸¸. 6
.
¸¸6 7
Manager
¸¸7 >
)
¸¸> ?
{
˝˝ 
user
˛˛ 
.
˛˛ 
OutletId
˛˛ 
=
˛˛ 
updateUserDto
˛˛  -
.
˛˛- .
OutletId
˛˛. 6
??
˛˛7 9
user
˛˛: >
.
˛˛> ?
OutletId
˛˛? G
;
˛˛G H
}
ˇˇ 
if
ÅÅ 
(
ÅÅ 
updateUserDto
ÅÅ 
.
ÅÅ 
ConsumerType
ÅÅ *
==
ÅÅ+ -
UserType
ÅÅ. 6
.
ÅÅ6 7
Business
ÅÅ7 ?
||
ÅÅ@ B
updateUserDto
ÅÅC P
.
ÅÅP Q
ConsumerType
ÅÅQ ]
==
ÅÅ^ `
UserType
ÅÅa i
.
ÅÅi j

Industries
ÅÅj t
)
ÅÅt u
{
ÇÇ 
user
ÉÉ 
.
ÉÉ "
BusinessRegistration
ÉÉ )
=
ÉÉ* +
updateUserDto
ÉÉ, 9
.
ÉÉ9 :"
BusinessRegistration
ÉÉ: N
??
ÉÉO Q
user
ÉÉR V
.
ÉÉV W"
BusinessRegistration
ÉÉW k
;
ÉÉk l
user
ÑÑ 
.
ÑÑ 
City
ÑÑ 
=
ÑÑ 
updateUserDto
ÑÑ )
.
ÑÑ) *
City
ÑÑ* .
??
ÑÑ/ 1
user
ÑÑ2 6
.
ÑÑ6 7
City
ÑÑ7 ;
;
ÑÑ; <
user
ÖÖ 
.
ÖÖ 
Address
ÖÖ 
=
ÖÖ 
updateUserDto
ÖÖ ,
.
ÖÖ, -
Address
ÖÖ- 4
??
ÖÖ5 7
user
ÖÖ8 <
.
ÖÖ< =
Address
ÖÖ= D
;
ÖÖD E
}
áá 
var
ää 
result
ää 
=
ää 
await
ää 
_userManager
ää +
.
ää+ ,
UpdateAsync
ää, 7
(
ää7 8
user
ää8 <
)
ää< =
;
ää= >
if
ãã 
(
ãã 
!
ãã 
result
ãã 
.
ãã 
	Succeeded
ãã  
)
ãã  !
return
ãã" (

StatusCode
ãã) 3
(
ãã3 4
$num
ãã4 7
,
ãã7 8
result
ãã9 ?
.
ãã? @
Errors
ãã@ F
)
ããF G
;
ããG H
var
çç 
updatedUser
çç 
=
çç 
await
çç #
_userManager
çç$ 0
.
çç0 1
FindByEmailAsync
çç1 A
(
ççA B
email
ççB G
)
ççG H
;
ççH I
return
éé 
Ok
éé 
(
éé 
new
éé  
NewUserResponseDto
éé ,
{
èè 
Email
ëë 
=
ëë 
updatedUser
ëë #
!
ëë# $
.
ëë$ %
Email
ëë% *
??
ëë+ -
throw
ëë. 3
new
ëë4 7'
InvalidOperationException
ëë8 Q
(
ëëQ R
)
ëëR S
,
ëëS T
FullName
íí 
=
íí 
updatedUser
íí &
.
íí& '
FullName
íí' /
??
íí0 2
throw
íí3 8
new
íí9 <'
InvalidOperationException
íí= V
(
ííV W
)
ííW X
,
ííX Y
NIC
ìì 
=
ìì 
updatedUser
ìì !
.
ìì! "
Nic
ìì" %
,
ìì% &"
BusinessRegistration
îî $
=
îî% &
updatedUser
îî' 2
.
îî2 3"
BusinessRegistration
îî3 G
,
îîG H
	IsConfirm
ïï 
=
ïï 
updatedUser
ïï '
.
ïï' (
	IsConfirm
ïï( 1
,
ïï1 2
OutletId
ññ 
=
ññ 
updatedUser
ññ &
.
ññ& '
OutletId
ññ' /
,
ññ/ 0
PhoneNumber
óó 
=
óó 
updatedUser
óó )
.
óó) *
PhoneNumber
óó* 5
??
óó6 8
throw
óó9 >
new
óó? B'
InvalidOperationException
óóC \
(
óó\ ]
)
óó] ^
,
óó^ _
Address
òò 
=
òò 
updatedUser
òò %
.
òò% &
Address
òò& -
,
òò- .
City
ôô 
=
ôô 
updatedUser
ôô "
.
ôô" #
City
ôô# '
,
ôô' ('
RemainingCylindersAllowed
öö )
=
öö* +
updatedUser
öö, 7
.
öö7 8'
RemainingCylindersAllowed
öö8 Q
,
ööQ R"
NoOfCylindersAllowed
õõ $
=
õõ% &
updatedUser
õõ' 2
.
õõ2 3"
NoOfCylindersAllowed
õõ3 G
,
õõG H
UserType
úú 
=
úú 
updatedUser
úú &
.
úú& '
ConsumerType
úú' 3
??
úú4 6
UserType
úú7 ?
.
úú? @
Personal
úú@ H
,
úúH I
Token
ùù 
=
ùù 
await
ùù 
_tokenService
ùù +
.
ùù+ ,
CreateToken
ùù, 7
(
ùù7 8
updatedUser
ùù8 C
)
ùùC D
}
ûû 
)
ûû 
;
ûû 
}
†† 	
catch
††	 
(
†† 
	Exception
†† 
e
†† 
)
†† 
{
°° 	
Console
¢¢ 
.
¢¢ 
	WriteLine
¢¢ 
(
¢¢ 
e
¢¢ 
)
¢¢  
;
¢¢  !
return
££ 

StatusCode
££ 
(
££ 
$num
££ !
,
££! "
e
££# $
.
££$ %
Message
££% ,
)
££, -
;
££- .
}
§§ 	
}
•• 
[
®® 
HttpPut
®® 
(
®® 
$str
®® *
)
®®* +
]
®®+ ,
public
©© 

async
©© 
Task
©© 
<
©© 
IActionResult
©© #
>
©©# $$
UpdateUserConfirmation
©©% ;
(
©©; <
[
©©< =
	FromRoute
©©= F
]
©©F G
string
©©H N
email
©©O T
,
©©T U
UpdateConfimDto
©©V e
updateConfimDto
©©f u
)
©©u v
{
™™ 
try
´´ 
{
¨¨ 	
if
≠≠ 
(
≠≠ 
!
≠≠ 

ModelState
≠≠ 
.
≠≠ 
IsValid
≠≠ #
)
≠≠# $
return
ÆÆ 

BadRequest
ÆÆ !
(
ÆÆ! "

ModelState
ÆÆ" ,
)
ÆÆ, -
;
ÆÆ- .
var
∞∞ 
user
∞∞ 
=
∞∞ 
await
∞∞ 
_userManager
∞∞ )
.
∞∞) *
FindByEmailAsync
∞∞* :
(
∞∞: ;
email
∞∞; @
)
∞∞@ A
;
∞∞A B
if
±± 
(
±± 
user
±± 
==
±± 
null
±± 
)
±± 
return
≤≤ 
NotFound
≤≤ 
(
≤≤  
$str
≤≤  0
)
≤≤0 1
;
≤≤1 2
user
∂∂ 
.
∂∂ 
	IsConfirm
∂∂ 
=
∂∂ 
updateConfimDto
∂∂ ,
.
∂∂, -
	IsConfirm
∂∂- 6
;
∂∂6 7
var
ππ 
result
ππ 
=
ππ 
await
ππ 
_userManager
ππ +
.
ππ+ ,
UpdateAsync
ππ, 7
(
ππ7 8
user
ππ8 <
)
ππ< =
;
ππ= >
if
ªª 
(
ªª 
!
ªª 
result
ªª 
.
ªª 
	Succeeded
ªª  
)
ªª  !
return
ªª" (

StatusCode
ªª) 3
(
ªª3 4
$num
ªª4 7
,
ªª7 8
result
ªª9 ?
.
ªª? @
Errors
ªª@ F
)
ªªF G
;
ªªG H
return
ºº 
Ok
ºº 
(
ºº 
new
ºº 
{
ºº 
message
ºº #
=
ºº$ %
$str
ºº& Z
}
ºº[ \
)
ºº\ ]
;
ºº] ^
}
ææ 	
catch
ææ	 
(
ææ 
	Exception
ææ 
e
ææ 
)
ææ 
{
øø 	
Console
¿¿ 
.
¿¿ 
	WriteLine
¿¿ 
(
¿¿ 
e
¿¿ 
)
¿¿  
;
¿¿  !
return
¡¡ 

StatusCode
¡¡ 
(
¡¡ 
$num
¡¡ !
,
¡¡! "
e
¡¡# $
.
¡¡$ %
Message
¡¡% ,
)
¡¡, -
;
¡¡- .
}
¬¬ 	
}
√√ 
[
≈≈ 
HttpPut
≈≈ 
(
≈≈ 
$str
≈≈ /
)
≈≈/ 0
]
≈≈0 1
public
∆∆ 

async
∆∆ 
Task
∆∆ 
<
∆∆ 
IActionResult
∆∆ #
>
∆∆# $&
UpdateRemainingCylinders
∆∆% =
(
∆∆= >
[
∆∆> ?
	FromRoute
∆∆? H
]
∆∆H I
string
∆∆J P
email
∆∆Q V
,
∆∆V W&
UpdateRemainingCylinders
∆∆X p$
remainingCylindersDto∆∆q Ü
)∆∆Ü á
{
«« 
try
»» 
{
…… 	
if
   
(
   
!
   

ModelState
   
.
   
IsValid
   #
)
  # $
return
ÀÀ 

BadRequest
ÀÀ !
(
ÀÀ! "

ModelState
ÀÀ" ,
)
ÀÀ, -
;
ÀÀ- .
var
ÕÕ 
user
ÕÕ 
=
ÕÕ 
await
ÕÕ 
_userManager
ÕÕ )
.
ÕÕ) *
FindByEmailAsync
ÕÕ* :
(
ÕÕ: ;
email
ÕÕ; @
)
ÕÕ@ A
;
ÕÕA B
if
ŒŒ 
(
ŒŒ 
user
ŒŒ 
==
ŒŒ 
null
ŒŒ 
)
ŒŒ 
return
œœ 
NotFound
œœ 
(
œœ  
$str
œœ  0
)
œœ0 1
;
œœ1 2
user
”” 
.
”” '
RemainingCylindersAllowed
”” *
=
””+ ,#
remainingCylindersDto
””- B
.
””B C'
RemainingCylindersAllowed
””C \
;
””\ ]
var
’’ 
result
’’ 
=
’’ 
await
’’ 
_userManager
’’ +
.
’’+ ,
UpdateAsync
’’, 7
(
’’7 8
user
’’8 <
)
’’< =
;
’’= >
if
÷÷ 
(
÷÷ 
!
÷÷ 
result
÷÷ 
.
÷÷ 
	Succeeded
÷÷  
)
÷÷  !
return
÷÷" (

StatusCode
÷÷) 3
(
÷÷3 4
$num
÷÷4 7
,
÷÷7 8
result
÷÷9 ?
.
÷÷? @
Errors
÷÷@ F
)
÷÷F G
;
÷÷G H
return
ÿÿ 
Ok
ÿÿ 
(
ÿÿ 
new
ÿÿ 
{
ÿÿ 
message
ÿÿ #
=
ÿÿ$ %
$str
ÿÿ& ^
}
ÿÿ_ `
)
ÿÿ` a
;
ÿÿa b
}
⁄⁄ 	
catch
⁄⁄	 
(
⁄⁄ 
	Exception
⁄⁄ 
e
⁄⁄ 
)
⁄⁄ 
{
€€ 	
Console
‹‹ 
.
‹‹ 
	WriteLine
‹‹ 
(
‹‹ 
e
‹‹ 
)
‹‹  
;
‹‹  !
return
›› 

StatusCode
›› 
(
›› 
$num
›› !
,
››! "
e
››# $
.
››$ %
Message
››% ,
)
››, -
;
››- .
}
ﬁﬁ 	
}
ﬂﬂ 
[
·· 
HttpPut
·· 
(
·· 
$str
·· -
)
··- .
]
··. /
public
‚‚ 

async
‚‚ 
Task
‚‚ 
<
‚‚ 
IActionResult
‚‚ #
>
‚‚# $$
UpdateAllowedCylinders
‚‚% ;
(
‚‚; <
[
‚‚< =
	FromRoute
‚‚= F
]
‚‚F G
string
‚‚H N
email
‚‚O T
,
‚‚T U'
UpdateAllowedCylindersDto
‚‚V o"
allowedCylindersDto‚‚p É
)‚‚É Ñ
{
„„ 
try
‰‰ 
{
ÂÂ 	
if
ÊÊ 
(
ÊÊ 
!
ÊÊ 

ModelState
ÊÊ 
.
ÊÊ 
IsValid
ÊÊ #
)
ÊÊ# $
return
ÁÁ 

BadRequest
ÁÁ !
(
ÁÁ! "

ModelState
ÁÁ" ,
)
ÁÁ, -
;
ÁÁ- .
var
ÈÈ 
user
ÈÈ 
=
ÈÈ 
await
ÈÈ 
_userManager
ÈÈ )
.
ÈÈ) *
FindByEmailAsync
ÈÈ* :
(
ÈÈ: ;
email
ÈÈ; @
)
ÈÈ@ A
;
ÈÈA B
if
ÍÍ 
(
ÍÍ 
user
ÍÍ 
==
ÍÍ 
null
ÍÍ 
)
ÍÍ 
return
ÎÎ 
NotFound
ÎÎ 
(
ÎÎ  
$str
ÎÎ  0
)
ÎÎ0 1
;
ÎÎ1 2
user
ÔÔ 
.
ÔÔ "
NoOfCylindersAllowed
ÔÔ %
=
ÔÔ& '!
allowedCylindersDto
ÔÔ( ;
.
ÔÔ; <"
NoOfCylindersAllowed
ÔÔ< P
;
ÔÔP Q
var
ÒÒ 
result
ÒÒ 
=
ÒÒ 
await
ÒÒ 
_userManager
ÒÒ +
.
ÒÒ+ ,
UpdateAsync
ÒÒ, 7
(
ÒÒ7 8
user
ÒÒ8 <
)
ÒÒ< =
;
ÒÒ= >
if
ÚÚ 
(
ÚÚ 
!
ÚÚ 
result
ÚÚ 
.
ÚÚ 
	Succeeded
ÚÚ  
)
ÚÚ  !
return
ÚÚ" (

StatusCode
ÚÚ) 3
(
ÚÚ3 4
$num
ÚÚ4 7
,
ÚÚ7 8
result
ÚÚ9 ?
.
ÚÚ? @
Errors
ÚÚ@ F
)
ÚÚF G
;
ÚÚG H
return
ÙÙ 
Ok
ÙÙ 
(
ÙÙ 
new
ÙÙ 
{
ÙÙ 
message
ÙÙ #
=
ÙÙ$ %
$str
ÙÙ& b
}
ÙÙc d
)
ÙÙd e
;
ÙÙe f
}
ˆˆ 	
catch
ˆˆ	 
(
ˆˆ 
	Exception
ˆˆ 
e
ˆˆ 
)
ˆˆ 
{
˜˜ 	
Console
¯¯ 
.
¯¯ 
	WriteLine
¯¯ 
(
¯¯ 
e
¯¯ 
)
¯¯  
;
¯¯  !
return
˘˘ 

StatusCode
˘˘ 
(
˘˘ 
$num
˘˘ !
,
˘˘! "
e
˘˘# $
.
˘˘$ %
Message
˘˘% ,
)
˘˘, -
;
˘˘- .
}
˙˙ 	
}
˚˚ 
[
˝˝ 

HttpDelete
˝˝ 
(
˝˝ 
$str
˝˝ %
)
˝˝% &
]
˝˝& '
public
˛˛ 

async
˛˛ 
Task
˛˛ 
<
˛˛ 
IActionResult
˛˛ #
>
˛˛# $

DeleteUser
˛˛% /
(
˛˛/ 0
[
˛˛0 1
	FromRoute
˛˛1 :
]
˛˛: ;
string
˛˛< B
email
˛˛C H
)
˛˛H I
{
ˇˇ 
try
ÄÄ 
{
ÅÅ 	
var
ÇÇ 
user
ÇÇ 
=
ÇÇ 
await
ÇÇ 
_userManager
ÇÇ )
.
ÇÇ) *
FindByEmailAsync
ÇÇ* :
(
ÇÇ: ;
email
ÇÇ; @
)
ÇÇ@ A
;
ÇÇA B
if
ÉÉ 
(
ÉÉ 
user
ÉÉ 
==
ÉÉ 
null
ÉÉ 
)
ÉÉ 
return
ÑÑ 
NotFound
ÑÑ 
(
ÑÑ  
$str
ÑÑ  0
)
ÑÑ0 1
;
ÑÑ1 2
var
ÜÜ 
result
ÜÜ 
=
ÜÜ 
await
ÜÜ 
_userManager
ÜÜ +
.
ÜÜ+ ,
DeleteAsync
ÜÜ, 7
(
ÜÜ7 8
user
ÜÜ8 <
)
ÜÜ< =
;
ÜÜ= >
if
áá 
(
áá 
!
áá 
result
áá 
.
áá 
	Succeeded
áá !
)
áá! "
return
àà 

StatusCode
àà !
(
àà! "
$num
àà" %
,
àà% &
result
àà' -
.
àà- .
Errors
àà. 4
)
àà4 5
;
àà5 6
return
ää 
Ok
ää 
(
ää 
new
ää 
{
ää 
message
ää #
=
ää$ %
$"
ää& (
$str
ää( -
{
ää- .
email
ää. 3
}
ää3 4
$str
ää4 I
"
ääI J
}
ääK L
)
ääL M
;
ääM N
}
ãã 	
catch
åå 
(
åå 
	Exception
åå 
e
åå 
)
åå 
{
çç 	
return
éé 

StatusCode
éé 
(
éé 
$num
éé !
,
éé! "
$str
éé# O
)
ééO P
;
ééP Q
}
èè 	
}
êê 
}íí 