Return-Path: <linux-tip-commits+bounces-2103-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB3B95D84B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 23:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BD21C211E0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 21:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACE8194AD9;
	Fri, 23 Aug 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c2LbS+Lj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fXPZVRcS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83477189B89;
	Fri, 23 Aug 2024 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724447106; cv=none; b=u0XemVV/nI/0mP+lSFFNyM9x5jK698maZKJRNAn/9aPi1H0sBY1sj+6vcGah2eqrfksgfnT5PNRDAi4lvyCinJF+rJ9XD9DRMgjucsB8XsAsyWkyoM7ItuYr4F1kkx6U3Gnuxb2Ba6gvpfvD58QpH/vOu++cvIIJa3Efhpv2oMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724447106; c=relaxed/simple;
	bh=ox2jYiZ8U+EpeLKvUKiCr26WsEt1LgMU0TnExRBDCls=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ZL12lZ52krUa9FdT9M0Qs2vy+PUb4ovtyfDcs9Q3zrzuPUkxGrzZDGdRzcvAZWX+rwfRz+GZeF8wAekFwMVVDaFiD90zAc1J1fmIcutNrgcB8csrYef/MqwBkivCVWNJ3Lsi4RkVGq+7qWH+ZTkNTwPjPxNPP/l0uOSxORSZINo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c2LbS+Lj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fXPZVRcS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Aug 2024 21:05:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724447102;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=IgoJXlScJJIs5QPuokDwh1R5rfSuaSkbFTLkMOO2tC4=;
	b=c2LbS+LjITwPNBkU3wBoPXTvLje8E8dUP2tzMwsi+XISFju/t/heS2UNfmqdQgTiQgPuES
	xsxcuq1Ymc8z91w2l7bnJdhKWblZPGVDSnnFyMO6jp0kax9yDngPrn3U8uZsaxVm7eqJDV
	fOmrpWiq4+FKb0nZhSGGQrs2hsoSR2UkG+T3JxbPB+Kj0yn1vS6HlRDskuRL4uQzmrDFor
	T913pVj6rEJlBBA7KZqvTyHBTlgRuP2juDkyh78N7JbmtqG+YFDUc1DYuVrLoP0HnNfrvC
	PxzstnNdEWyOUISSciN4TRbmgz9H353d5KLMSGKAyTUQ684c9nGs/+QFkR5mqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724447102;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=IgoJXlScJJIs5QPuokDwh1R5rfSuaSkbFTLkMOO2tC4=;
	b=fXPZVRcSBpjYXq1PkZ30VNYU+Vg3OoULOGWCruBuQB31LRCmN7e9clIXvEXIarih0oFfAl
	iWlsqrj/SqU9VPDA==
From: "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] x86/syscall: Avoid memcpy() for ia32 syscall_get_arguments()
Cc: Mirsad Todorovac <mtodorovac69@gmail.com>, Kees Cook <kees@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172444710177.2215.15316264335505039763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     d19d638b1e6cf746263ef60b7d0dee0204d8216a
Gitweb:        https://git.kernel.org/tip/d19d638b1e6cf746263ef60b7d0dee0204d=
8216a
Author:        Kees Cook <kees@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 13:22:06 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 23 Aug 2024 11:46:51 -07:00

x86/syscall: Avoid memcpy() for ia32 syscall_get_arguments()

Modern (fortified) memcpy() prefers to avoid writing (or reading) beyond
the end of the addressed destination (or source) struct member:

In function =E2=80=98fortify_memcpy_chk=E2=80=99,
    inlined from =E2=80=98syscall_get_arguments=E2=80=99 at ./arch/x86/includ=
e/asm/syscall.h:85:2,
    inlined from =E2=80=98populate_seccomp_data=E2=80=99 at kernel/seccomp.c:=
258:2,
    inlined from =E2=80=98__seccomp_filter=E2=80=99 at kernel/seccomp.c:1231:=
3:
./include/linux/fortify-string.h:580:25: error: call to =E2=80=98__read_overf=
low2_field=E2=80=99 declared with attribute warning: detected read beyond siz=
e of field (2nd parameter); maybe use struct_group()? [-Werror=3Dattribute-wa=
rning]
  580 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As already done for x86_64 and compat mode, do not use memcpy() to
extract syscall arguments from struct pt_regs but rather just perform
direct assignments. Binary output differences are negligible, and actually
ends up using less stack space:

-       sub    $0x84,%esp
+       sub    $0x6c,%esp

and less text size:

   text    data     bss     dec     hex filename
  10794     252       0   11046    2b26 gcc-32b/kernel/seccomp.o.stock
  10714     252       0   10966    2ad6 gcc-32b/kernel/seccomp.o.after

Closes: https://lore.kernel.org/lkml/9b69fb14-df89-4677-9c82-056ea9e706f5@gma=
il.com/
Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Mirsad Todorovac <mtodorovac69@gmail.com>
Link: https://lore.kernel.org/all/20240708202202.work.477-kees%40kernel.org
---
 arch/x86/include/asm/syscall.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 2fc7bc3..7c488ff 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -82,7 +82,12 @@ static inline void syscall_get_arguments(struct task_struc=
t *task,
 					 struct pt_regs *regs,
 					 unsigned long *args)
 {
-	memcpy(args, &regs->bx, 6 * sizeof(args[0]));
+	args[0] =3D regs->bx;
+	args[1] =3D regs->cx;
+	args[2] =3D regs->dx;
+	args[3] =3D regs->si;
+	args[4] =3D regs->di;
+	args[5] =3D regs->bp;
 }
=20
 static inline int syscall_get_arch(struct task_struct *task)

