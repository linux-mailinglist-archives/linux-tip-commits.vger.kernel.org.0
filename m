Return-Path: <linux-tip-commits+bounces-7627-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 902B6CB251A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Dec 2025 08:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74ADD3004D25
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Dec 2025 07:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44EE23D7E6;
	Wed, 10 Dec 2025 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e1JlVTax";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="foQsKDHt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D19819CD06;
	Wed, 10 Dec 2025 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765352828; cv=none; b=oGzH6KA7ZHGx4+Ztcjh/SwvQTfS+r9wFO9b1EolvOrokZG8ZgTaNKfWYgY5Ih3vJny1mF/+Wg8lO1mloRRhVWgC/d1Ghu91KoistbrJkcOBiyfS3tjic4GEWF4BmYm1/ajdGzCbRRz+EGoK5DDnHsVHeY1Fh+4MLSq7NqFQzDqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765352828; c=relaxed/simple;
	bh=NAE66TZfCcPanlZznqbJd0YtzQdY2I4918fwCghtzI0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YXnlB+VqNHcmv39V4YehgOvXNJna/2HnZ43DtO65n0tIGLewMwLX2xuLp7jQW1oNn08AIjjQstKWMicwNnWKLNQ+nsXpcI4Ln+IrGEM48Um9ncL2defe+SdLEdp3pJadsujpQD6FIK7lWqjmzJvO3aNVbMn5a7OJ5zgsCJbBVro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e1JlVTax; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=foQsKDHt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Dec 2025 07:47:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765352825;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmwtBs/zhn8pBV3Syoh/Qf2pfDGtBCcXCcKC6RYVKFA=;
	b=e1JlVTaxFAvDA8k+D/HnSa053EJImNX7LX3Ma1GvXQZevggovmXB6Q7rykB0cLaL3u89J2
	oB5dQFewmL07lHmmwy05oKQAc099GROXnZAmOxy8j4OGML1ZyWP/P+XLc5NfCIeEZzot73
	ArbbdfKmpOHi3xLzB+iVwWsw4XKzQBI5+z46dCS16f6F0c7hT6g4oUTZFUFFFEfX4Hd4XN
	4/uF8G380aZSxxjCUjbVgUFiF6MUiJn+wcr3/d0b4CKNI+AX88kY2DCqc8wPU9nSoJKPsg
	XeRwooiYY3iKTf/5vWvlyH8/3v93FDhWrnBTsA4F/JK+yq+3Y1QobKxr4U3aGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765352825;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmwtBs/zhn8pBV3Syoh/Qf2pfDGtBCcXCcKC6RYVKFA=;
	b=foQsKDHtNaiNP2Qflhvdt7Cl1Gn0FaYGJLmyhXDKzeTpGHsCiUD2Yr0S2n6UP/NKfBZxie
	WnxgZy7iuT3PKcDg==
From: "tip-bot2 for Yongxin Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Fix FPU state core dump truncation on CPUs
 with no extended xfeatures
Cc: Yongxin Liu <yongxin.liu@windriver.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251210000219.4094353-2-yongxin.liu@windriver.com>
References: <20251210000219.4094353-2-yongxin.liu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176535282315.498.10251081753003110803.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c8161e5304abb26e6c0bec6efc947992500fa6c5
Gitweb:        https://git.kernel.org/tip/c8161e5304abb26e6c0bec6efc947992500=
fa6c5
Author:        Yongxin Liu <yongxin.liu@windriver.com>
AuthorDate:    Wed, 10 Dec 2025 08:02:20 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Dec 2025 08:44:34 +01:00

x86/fpu: Fix FPU state core dump truncation on CPUs with no extended xfeatures

Zero can be a valid value of num_records. For example, on Intel Atom x6425RE,
only x87 and SSE are supported (features 0, 1), and fpu_user_cfg.max_features
is 3. The for_each_extended_xfeature() loop only iterates feature 2, which is
not enabled, so num_records =3D 0. This is valid and should not cause core du=
mp
failure.

The issue is that dump_xsave_layout_desc() returns 0 for both genuine errors
(dump_emit() failure) and valid cases (no extended features). Use negative
return values for errors and only abort on genuine failures.

Fixes: ba386777a30b ("x86/elf: Add a new FPU buffer layout info to x86 core f=
iles")
Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251210000219.4094353-2-yongxin.liu@windriver=
.com
---
 arch/x86/kernel/fpu/xstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 48113c5..76153df 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1946,7 +1946,7 @@ static int dump_xsave_layout_desc(struct coredump_param=
s *cprm)
 		};
=20
 		if (!dump_emit(cprm, &xc, sizeof(xc)))
-			return 0;
+			return -1;
=20
 		num_records++;
 	}
@@ -1984,7 +1984,7 @@ int elf_coredump_extra_notes_write(struct coredump_para=
ms *cprm)
 		return 1;
=20
 	num_records =3D dump_xsave_layout_desc(cprm);
-	if (!num_records)
+	if (num_records < 0)
 		return 1;
=20
 	/* Total size should be equal to the number of records */

