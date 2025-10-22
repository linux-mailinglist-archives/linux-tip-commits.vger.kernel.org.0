Return-Path: <linux-tip-commits+bounces-6984-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE721BFC34B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Oct 2025 15:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9424D62362F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Oct 2025 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB53346E68;
	Wed, 22 Oct 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PbiMjnms";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ry2t9JBN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5DF346786;
	Wed, 22 Oct 2025 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139742; cv=none; b=L9m27P/Oakw34LbwN/DK07zBa2J7GOgHSvsQ8WkL2RPALDbGshgDFqq5mUoDt8uG+f5MsIa18EPuvvQJ5JwVI/+MfrW1FAAzBmk8IsNtjc1w8WU0v3+Q6OsHMKqECIGmbfJsA95UTVNLA6OjLrm2iePoSOaUBFuaiAtGjqgPaWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139742; c=relaxed/simple;
	bh=pVMDJbZmaVkxwkscr47qIjxsD+a0kQ1fFXf/7K4ehWo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qEPkzBqts23YHbX1NK1gaVIDDvdRCSPSzA4AIKkw43rG1G4qUGAxDiDkxPUDBl4LRxxs/w+CeYbRvCYmCe84sGcWoRCwdwwUzVQ3U0NLHeKfG6iwJUwXcKZI17U8nvHAu0KQoYIOeyJk3AQ9wbPC/UhapO3iTAGZqYRYx+75COY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PbiMjnms; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ry2t9JBN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 22 Oct 2025 13:28:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761139739;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INsZ1QN0vDVvHvYkw6LTz/ILVenBDgmnSeZjfXXQIEc=;
	b=PbiMjnms1X0hNP9kfkx8ifYB4OJnoIjIH6TyBDyGf7dqprECbd6XhyW2TbnEsGeHdxNIVE
	JKf9znWbqeWeJEBeTH+lq0Ia1ip2IjwV8csjGC3Qt4G0uJxJL0S7ityJJogXI61NLo50XL
	HjWwhUSTkYTO3WAaFUq9hiMcnS9GWqraSC2ELIU9kMXot2w9ey2VsTmwew0HYr7d+5ghQb
	T0z9hbVymJGja+T+i6qU8T8rX7FTH5pvdXeRQwG/RzP3Q2T2+4aPjO1VEwNI9tz+3DJQ0d
	wpFPAqel7MS5ncFnn3QAAbACsrBcHqGaxUL1K+TG/SLhW8IVspuvHHZXkH+E3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761139739;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INsZ1QN0vDVvHvYkw6LTz/ILVenBDgmnSeZjfXXQIEc=;
	b=Ry2t9JBNgjh9OF+M9nxtY2c7OH3K1bjG9KWibPuTo8Ykopj1cyKD2EUG0Uhqj0s83qNEch
	WKB6Kp0iD9/hpODQ==
From: "tip-bot2 for Mikulas Patocka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/urgent] objtool: Fix failure when being compiled on x32 system
Cc: Mikulas Patocka <mpatocka@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <1ac32fff-2e67-5155-f570-69aad5bf5412@redhat.com>
References: <1ac32fff-2e67-5155-f570-69aad5bf5412@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176113973808.2601451.324362965396577323.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     49c98f30f4021b560676a336f8a46a4f642eee2b
Gitweb:        https://git.kernel.org/tip/49c98f30f4021b560676a336f8a46a4f642=
eee2b
Author:        Mikulas Patocka <mpatocka@redhat.com>
AuthorDate:    Mon, 20 Oct 2025 14:23:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Oct 2025 15:21:55 +02:00

objtool: Fix failure when being compiled on x32 system

Fix compilation failure when compiling the kernel with the x32 toolchain.

In file included from check.c:16:
check.c: In function =C2=A1check_abs_references=C2=A2:
/usr/src/git/linux-2.6/tools/objtool/include/objtool/warn.h:47:17: error: for=
mat =C2=A1%lx=C2=A2 expects argument of type =C2=A1long unsigned int=C2=A2, b=
ut argument 7 has type =C2=A1u64=C2=A2 {aka =C2=A1long
long unsigned int=C2=A2} [-Werror=3Dformat=3D]
   47 |                 "%s%s%s: objtool" extra ": " format "\n",            =
   \
      |                 ^~~~~~~~~~~~~~~~~
/usr/src/git/linux-2.6/tools/objtool/include/objtool/warn.h:54:9: note: in ex=
pansion of macro =C2=A1___WARN=C2=A2
   54 |         ___WARN(severity, "", format, ##__VA_ARGS__)
      |         ^~~~~~~
/usr/src/git/linux-2.6/tools/objtool/include/objtool/warn.h:74:27: note: in e=
xpansion of macro =C2=A1__WARN=C2=A2
   74 | #define WARN(format, ...) __WARN(WARN_STR, format, ##__VA_ARGS__)
      |                           ^~~~~~
check.c:4713:33: note: in expansion of macro =C2=A1WARN=C2=A2
 4713 |                                 WARN("section %s has absolute relocat=
ion at offset 0x%lx",
      |                                 ^~~~

Fixes: 0d6e4563fc03 ("objtool: Add action to check for absence of absolute re=
locations")
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://patch.msgid.link/1ac32fff-2e67-5155-f570-69aad5bf5412@redhat.com
---
 tools/objtool/check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3c7ab91..620854f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4711,8 +4711,8 @@ static int check_abs_references(struct objtool_file *fi=
le)
=20
 		for_each_reloc(sec->rsec, reloc) {
 			if (arch_absolute_reloc(file->elf, reloc)) {
-				WARN("section %s has absolute relocation at offset 0x%lx",
-				     sec->name, reloc_offset(reloc));
+				WARN("section %s has absolute relocation at offset 0x%llx",
+				     sec->name, (unsigned long long)reloc_offset(reloc));
 				ret++;
 			}
 		}

