Return-Path: <linux-tip-commits+bounces-2956-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430939E185D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 10:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BBE287754
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 09:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B931E00BD;
	Tue,  3 Dec 2024 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mfb-afg.ir header.i=@mfb-afg.ir header.b="R7BcC24L"
Received: from IR1.serversetup.co (IR1.serversetup.co [31.214.250.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB11E009F
	for <linux-tip-commits@vger.kernel.org>; Tue,  3 Dec 2024 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.214.250.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219746; cv=none; b=qtAYWi9V212Wqy7PLlyNVjf4rx6fpYOSz5B/T83ygSo4t5HNlkmBZbc2IwbqFMkEVZiQRYYNgmAznJjA5M7emassDJWh8MGe0wdhwNHICGz2i3eOqBeATXayyc+DRZTMZSYK7A+I/huVpoH/aDPGh2R2HYTU1f60pnu6hGc6Auw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219746; c=relaxed/simple;
	bh=XuQnNhyEywhizFiadbBMa7LCYNXB2ZyPupDq1qTpPUM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QRssnyvfbtdQ9BXPkwHCrPewgHTcZbH5+gRyySIQr4nadF3qE1USsH/V2spXnSTDPfZ0ka97e76owxm0YYFMtmBb7sWZOjyDJc7VysKXdjUDqOsh0JskNIbXkma6TR0ruy6dRz4fcyIqjvf++1LUNLbwKbflKZNzMMSZaVQzYXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mfb-afg.ir; spf=pass smtp.mailfrom=mfb-afg.ir; dkim=pass (2048-bit key) header.d=mfb-afg.ir header.i=@mfb-afg.ir header.b=R7BcC24L; arc=none smtp.client-ip=31.214.250.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mfb-afg.ir
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mfb-afg.ir
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mfb-afg.ir;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XuQnNhyEywhizFiadbBMa7LCYNXB2ZyPupDq1qTpPUM=; b=R7BcC24LN2nB5s6kQ3jzsPHIEu
	3CCTJoIiUadH/MyE80mLkFFJdQgHEEk5kvCmd7nMFe3apTTEDVFX25WFABFXl09MwLDum285/6Wau
	JOk0teK3J6D76KntqwT4DN/ppYiqR9kE6ygz8FPkn+k7HRtai4UFGOF2cRMghf2ATXyQxo6TgyXvK
	+XPe3ygcdx9+2iL526yJG0v/jSOTUexv5YxvIWVvtp83viIqz7SfVXm635OhTQiIfCpOOX1mGzTds
	Hi94195K/NSWfYmJgIbBxCDz/x8tTHqIQlH+2M9wwa/OVfiBArr08I6phiWIBo7sBZnBaupxkGwzx
	YYipmSiA==;
Received: from mail.iosystem.co.kr ([112.169.152.4]:39474 helo=[103.153.69.73])
	by ir1.serversetup.co with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <supports@mfb-afg.ir>)
	id 1tIHDb-0002JZ-0x
	for linux-tip-commits@vger.kernel.org;
	Tue, 03 Dec 2024 04:26:52 +0330
From: "tgs" <supports@mfb-afg.ir>
To: linux-tip-commits@vger.kernel.org
Subject: wvvgj
Date: 3 Dec 2024 02:56:41 +0200
Message-ID: <20241203025641.1E9EE10859DF323B@mfb-afg.ir>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ir1.serversetup.co
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mfb-afg.ir
X-Get-Message-Sender-Via: ir1.serversetup.co: authenticated_id: supports@mfb-afg.ir
X-Authenticated-Sender: ir1.serversetup.co: supports@mfb-afg.ir
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hell=C6=A1, m=D2=AF per=D1=B5erted fr=CE=90e=C6=9Ed,



We'=D1=B5e a=CF=82t=DF=8Eall=D2=AF k=C6=9E=C6=A1w=C6=9E ea=CF=82=D2=BB =C6=
=A1t=D2=BBer f=C6=A1r a w=D2=BB=CE=90le, at least =C4=B0 k=C6=9E=C6=A1w =D2=
=AF=C6=A1=DF=8E.

Y=C6=A1=DF=8E =CF=82a=C6=9E =CF=82all me =C3=9F=CE=90g =C3=9Fr=C6=A1t=D2=BB=
er =C6=A1r t=D2=BBe All-See=CE=90=C6=9Eg E=D2=AFe.

=C4=B0'm a =D2=BBa=CF=82ker w=D2=BB=C6=A1 a few m=C6=A1=C6=9Et=D2=BBs ag=C6=
=A1 ga=CE=90=C6=9Eed a=CF=82=CF=82ess t=C6=A1 =D2=AF=C6=A1=DF=8Er de=D1=B5=
=CE=90=CF=82e, =CE=90=C6=9E=CF=82l=DF=8Ed=CE=90=C6=9Eg =D2=AF=C6=A1=DF=8Er =
br=C6=A1wser =D2=BB=CE=90st=C6=A1r=D2=AF a=C6=9Ed web=CF=82am.

=C4=B0 re=CF=82=C6=A1rded s=C6=A1me =D1=B5=CE=90de=C6=A1s =C6=A1f =D2=AF=C6=
=A1=DF=8E jerk=CE=90=C6=9Eg =C6=A1ff t=C6=A1 =D2=BB=CE=90g=D2=BBl=D2=AF =CF=
=82=C6=A1=C6=9Etr=C6=A1=D1=B5ers=CE=90al "ad=DF=8Elt" =D1=B5=CE=90de=C6=A1s=
=2E

=C4=B0 d=C6=A1=DF=8Ebt =D2=AF=C6=A1=DF=8E'd wa=C6=9Et =D2=AF=C6=A1=DF=8Er f=
am=CE=90l=D2=AF, =CF=82=C6=A1w=C6=A1rkers, a=C6=9Ed =D2=AF=C6=A1=DF=8Er e=
=C6=9Et=CE=90re =CF=82=C6=A1=C6=9Eta=CF=82t l=CE=90st t=C6=A1 see f=C6=A1=
=C6=A1tage =C6=A1f =D2=AF=C6=A1=DF=8E pleas=DF=8Er=CE=90=C6=9Eg =D2=AF=C6=
=A1=DF=8Erself,

espe=CF=82=CE=90all=D2=AF =CF=82=C6=A1=C6=9Es=CE=90der=CE=90=C6=9Eg =D2=BB=
=C6=A1w k=CE=90=C6=9Ek=D2=AF =D2=AF=C6=A1=DF=8Er fa=D1=B5=C6=A1r=CE=90te "g=
e=C6=9Ere".

=C4=B0 w=CE=90ll als=C6=A1 p=DF=8Ebl=CE=90s=D2=BB t=D2=BBese =D1=B5=CE=90de=
=C6=A1s =C6=A1=C6=9E p=C6=A1r=C6=9E s=CE=90tes, t=D2=BBe=D2=AF w=CE=90ll g=
=C6=A1 =D1=B5=CE=90ral a=C6=9Ed =CE=90t w=CE=90ll be p=D2=BB=D2=AFs=CE=90=
=CF=82all=D2=AF =CE=90mp=C6=A1ss=CE=90ble t=C6=A1 rem=C6=A1=D1=B5e t=D2=BBe=
m fr=C6=A1m t=D2=BBe =C4=B0=C6=9Eter=C6=9Eet.



H=C6=A1w d=CE=90d =C4=B0 d=C6=A1 t=D2=BB=CE=90s?

=C3=9Fe=CF=82a=DF=8Ese =C6=A1f =D2=AF=C6=A1=DF=8Er d=CE=90sregard f=C6=A1r =
=CE=90=C6=9Eter=C6=9Eet se=CF=82=DF=8Er=CE=90t=D2=AF, =C4=B0 eas=CE=90l=D2=
=AF ma=C6=9Eaged t=C6=A1 =CE=90=C6=9Estall a Tr=C6=A1ja=C6=9E =C6=A1=C6=9E =
=D2=AF=C6=A1=DF=8Er =D2=BBard d=CE=90sk.

T=D2=BBa=C6=9Eks t=C6=A1 t=D2=BB=CE=90s, =C4=B0 was able t=C6=A1 a=CF=82=CF=
=82ess all t=D2=BBe data =C6=A1=C6=9E =D2=AF=C6=A1=DF=8Er de=D1=B5=CE=90=CF=
=82e a=C6=9Ed =CF=82=C6=A1=C6=9Etr=C6=A1l =CE=90t rem=C6=A1tel=D2=AF.

=C3=9F=D2=AF =CE=90=C6=9Efe=CF=82t=CE=90=C6=9Eg =C6=A1=C6=9Ee de=D1=B5=CE=
=90=CF=82e, =C4=B0 was able t=C6=A1 ga=CE=90=C6=9E a=CF=82=CF=82ess t=C6=A1=
 all t=D2=BBe =C6=A1t=D2=BBer de=D1=B5=CE=90=CF=82es.



M=D2=AF sp=D2=AFware =CE=90s embedded =CE=90=C6=9E t=D2=BBe dr=CE=90=D1=B5e=
rs a=C6=9Ed =DF=8Epdates =CE=90ts s=CE=90g=C6=9Eat=DF=8Ere e=D1=B5er=D2=AF =
few =D2=BB=C6=A1=DF=8Ers, s=C6=A1 =C6=9E=C6=A1 a=C6=9Et=CE=90=D1=B5=CE=90r=
=DF=8Es =C6=A1r f=CE=90rewall =CF=82a=C6=9E e=D1=B5er dete=CF=82t =CE=90t.

N=C6=A1w =C4=B0 wa=C6=9Et t=C6=A1 =C6=A1ffer a deal: a small am=C6=A1=DF=8E=
=C6=9Et =C6=A1f m=C6=A1=C6=9Ee=D2=AF =CE=90=C6=9E ex=CF=82=D2=BBa=C6=9Ege f=
=C6=A1r =D2=AF=C6=A1=DF=8Er f=C6=A1rmer w=C6=A1rr=D2=AF free l=CE=90fe.



Tra=C6=9Esfer $1450 USD t=C6=A1 m=D2=AF b=CE=90t=CF=82=C6=A1=CE=90=C6=9E wa=
llet: 12345678aUr3n9grGy2vt8rxb3sSSBsuBJ



As s=C6=A1=C6=A1=C6=9E as =C4=B0 re=CF=82e=CE=90=D1=B5e =CF=82=C6=A1=C6=9Ef=
=CE=90rmat=CE=90=C6=A1=C6=9E =C6=A1f t=D2=BBe pa=D2=AFme=C6=9Et,

=C4=B0 w=CE=90ll delete all t=D2=BBe =D1=B5=CE=90de=C6=A1s t=D2=BBat =CF=82=
=C6=A1mpr=C6=A1m=CE=90se =D2=AF=C6=A1=DF=8E, rem=C6=A1=D1=B5e t=D2=BBe =D1=
=B5=CE=90r=DF=8Es fr=C6=A1m all =D2=AF=C6=A1=DF=8Er de=D1=B5=CE=90=CF=82es =
a=C6=9Ed =D2=AF=C6=A1=DF=8E w=CE=90ll =C6=9Ee=D1=B5er =D2=BBear fr=C6=A1m m=
e aga=CE=90=C6=9E.

=C4=B0t's a =D1=B5er=D2=AF small pr=CE=90=CF=82e f=C6=A1r =C6=9E=C6=A1t des=
tr=C6=A1=D2=AF=CE=90=C6=9Eg =D2=AF=C6=A1=DF=8Er rep=DF=8Etat=CE=90=C6=A1=C6=
=9E =CE=90=C6=9E t=D2=BBe e=D2=AFes =C6=A1f =C6=A1t=D2=BBers, w=D2=BB=C6=A1=
 t=D2=BB=CE=90=C6=9Ek t=D2=BBat =D2=AF=C6=A1=DF=8E are a de=CF=82e=C6=9Et m=
a=C6=9E, a=CF=82=CF=82=C6=A1rd=CE=90=C6=9Eg t=C6=A1 =D2=AF=C6=A1=DF=8Er mes=
se=C6=9Egers.

Y=C6=A1=DF=8E =CF=82a=C6=9E t=D2=BB=CE=90=C6=9Ek =C6=A1f me as s=C6=A1me s=
=C6=A1rt =C6=A1f l=CE=90fe =CF=82=C6=A1a=CF=82=D2=BB w=D2=BB=C6=A1 wa=C6=9E=
ts =D2=AF=C6=A1=DF=8E t=C6=A1 start appre=CF=82=CE=90at=CE=90=C6=9Eg w=D2=
=BBat =D2=AF=C6=A1=DF=8E =D2=BBa=D1=B5e.



Y=C6=A1=DF=8E =D2=BBa=D1=B5e 48 =D2=BB=C6=A1=DF=8Ers. =C4=B0 w=CE=90ll re=
=CF=82e=CE=90=D1=B5e a =C6=9E=C6=A1t=CE=90f=CE=90=CF=82at=CE=90=C6=A1=C6=9E=
 as s=C6=A1=C6=A1=C6=9E as =D2=AF=C6=A1=DF=8E =C6=A1pe=C6=9E t=D2=BB=CE=90s=
 ema=CE=90l, a=C6=9Ed fr=C6=A1m t=D2=BB=CE=90s m=C6=A1me=C6=9Et, t=D2=BBe =
=CF=82=C6=A1=DF=8E=C6=9Etd=C6=A1w=C6=9E w=CE=90ll beg=CE=90=C6=9E.

=C4=B0f =D2=AF=C6=A1=DF=8E'=D1=B5e =C6=9Ee=D1=B5er dealt w=CE=90t=D2=BB =CF=
=82r=D2=AFpt=C6=A1=CF=82=DF=8Erre=C6=9E=CF=82=D2=AF bef=C6=A1re, =CE=90t's =
=D1=B5er=D2=AF eas=D2=AF. S=CE=90mpl=D2=AF t=D2=AFpe "=CF=82r=D2=AFpt=C6=A1=
=CF=82=DF=8Erre=C6=9E=CF=82=D2=AF ex=CF=82=D2=BBa=C6=9Ege" =CE=90=C6=9Et=C6=
=A1 a sear=CF=82=D2=BB e=C6=9Eg=CE=90=C6=9Ee, a=C6=9Ed t=D2=BBe=C6=9E all s=
et.



Here's w=D2=BBat =D2=AF=C6=A1=DF=8E s=D2=BB=C6=A1=DF=8Eld=C6=9E't d=C6=A1:

- D=C6=A1=C6=9E't repl=D2=AF t=C6=A1 m=D2=AF ema=CE=90l. =C4=B0t was se=C6=
=9Et fr=C6=A1m a temp=C6=A1rar=D2=AF ema=CE=90l a=CF=82=CF=82=C6=A1=DF=8E=
=C6=9Et.

- D=C6=A1=C6=9E't =CF=82all t=D2=BBe p=C6=A1l=CE=90=CF=82e.

Remember, =C4=B0 =D2=BBa=D1=B5e a=CF=82=CF=82ess t=C6=A1 all =D2=AF=C6=A1=
=DF=8Er de=D1=B5=CE=90=CF=82es, a=C6=9Ed as s=C6=A1=C6=A1=C6=9E as =C4=B0 =
=C6=9E=C6=A1t=CE=90=CF=82e s=DF=8E=CF=82=D2=BB a=CF=82t=CE=90=D1=B5=CE=90t=
=D2=AF, =CE=90t w=CE=90ll a=DF=8Et=C6=A1mat=CE=90=CF=82all=D2=AF lead t=C6=
=A1 t=D2=BBe p=DF=8Ebl=CE=90s=D2=BB=CE=90=C6=9Eg =C6=A1f all t=D2=BBe =D1=
=B5=CE=90de=C6=A1s.

- D=C6=A1=C6=9E't tr=D2=AF t=C6=A1 re=CE=90=C6=9Estall =D2=AF=C6=A1=DF=8Er =
s=D2=AFstem =C6=A1r reset =D2=AF=C6=A1=DF=8Er de=D1=B5=CE=90=CF=82e. F=CE=
=90rst =C6=A1f all, =C4=B0 alread=D2=AF =D2=BBa=D1=B5e t=D2=BBe =D1=B5=CE=
=90de=C6=A1s,

a=C6=9Ed se=CF=82=C6=A1=C6=9Edl=D2=AF, as =C4=B0 sa=CE=90d, =C4=B0 =D2=BBa=
=D1=B5e rem=C6=A1te a=CF=82=CF=82ess t=C6=A1 all =D2=AF=C6=A1=DF=8Er de=D1=
=B5=CE=90=CF=82es, a=C6=9Ed =C6=A1=C6=9E=CF=82e =C4=B0 =C6=9E=C6=A1t=CE=90=
=CF=82e s=DF=8E=CF=82=D2=BB a=C6=9E attempt, =D2=AF=C6=A1=DF=8E k=C6=9E=C6=
=A1w w=D2=BBat =D2=BBappe=C6=9Es.


Remember, =CF=82r=D2=AFpt=C6=A1 addresses are a=C6=9E=C6=A1=C6=9E=D2=AFm=C6=
=A1=DF=8Es, s=C6=A1 =D2=AF=C6=A1=DF=8E w=C6=A1=C6=9E't be able t=C6=A1 tra=
=CF=82k d=C6=A1w=C6=9E m=D2=AF wallet.



S=C6=A1 l=C6=A1=C6=9Eg st=C6=A1r=D2=AF s=D2=BB=C6=A1rt, let's res=C6=A1l=D1=
=B5e t=D2=BB=CE=90s s=CE=90t=DF=8Eat=CE=90=C6=A1=C6=9E w=CE=90t=D2=BB a be=
=C6=9Eef=CE=90t f=C6=A1r me a=C6=9Ed =D2=AF=C6=A1=DF=8E.

=C4=B0 alwa=D2=AFs keep m=D2=AF w=C6=A1rd =DF=8E=C6=9Eless s=C6=A1me=C6=A1=
=C6=9Ee tr=CE=90es t=C6=A1 tr=CE=90=CF=82k me.



Lastl=D2=AF, a l=CE=90ttle ad=D1=B5=CE=90=CF=82e f=C6=A1r t=D2=BBe f=DF=8Et=
=DF=8Ere. Start tak=CE=90=C6=9Eg =D2=AF=C6=A1=DF=8Er =C6=A1=C6=9El=CE=90=C6=
=9Ee se=CF=82=DF=8Er=CE=90t=D2=AF m=C6=A1re ser=CE=90=C6=A1=DF=8Esl=D2=AF.

C=D2=BBa=C6=9Ege =D2=AF=C6=A1=DF=8Er passw=C6=A1rds reg=DF=8Elarl=D2=AF a=
=C6=9Ed set =DF=8Ep m=DF=8Elt=CE=90-fa=CF=82t=C6=A1r a=DF=8Et=D2=BBe=C6=9Et=
=CE=90=CF=82at=CE=90=C6=A1=C6=9E =C6=A1=C6=9E all =D2=AF=C6=A1=DF=8Er a=CF=
=82=CF=82=C6=A1=DF=8E=C6=9Ets.



=C3=9Fest w=CE=90s=D2=BBes.

