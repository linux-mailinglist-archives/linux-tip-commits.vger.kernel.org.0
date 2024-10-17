Return-Path: <linux-tip-commits+bounces-2507-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E8D9A2E43
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 22:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C093D1F22F1E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 20:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702E3227BAB;
	Thu, 17 Oct 2024 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZXxyQHwl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gkSYhkLn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29FD1791ED;
	Thu, 17 Oct 2024 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729195860; cv=none; b=o2p5Jl2xmJJtcn0BLlpzxaDHySRSPBjPTKoz74QUhbNsSu2X1g49p2daxc2QXiK9hHrg2p9l9t38x9bNC/PX5eymXpG2UmsEXo8Mu4+whMiseMngE6BDmFJHFI1Hm/bb0FqPdWvXdjBMBeDCic9u0wauwiJabSlF1sRRMxIZrJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729195860; c=relaxed/simple;
	bh=V4wbjWRtVJ1R49vICPNCrW24WaVLPucEZyeegSl6zPE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PH+Rm1bez6E/tuj3mhJ0HeRZyyz4kAryPUvds6glJh/jxmyySh1J85xqHWdgyxLPFW/4nmPIdkyxtbMFDOei3Z6Yki9UM+3X3KP8/QnT/XkGwZbt4wpfAgIbldKXXqrJScWOPficzzTXAcON7RUyBPUp0+R1RmBWcPnrlwNuB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZXxyQHwl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gkSYhkLn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Oct 2024 20:10:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729195851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZt+XWadWsIegJ888x39wB3zAvBhXrCUUAGJ4erQzpI=;
	b=ZXxyQHwlzpTc8RPnS3wrMjHBI+bAmCqhivFft1qbaXwPUjkCp9dBUUxhETq9VHbwdUBFd2
	A3mpU0Y2fdJlPY+4JTuEVdeAs7Y8u/O8eoylM0PYfvFkRm8GPl2005wlWKoTJ5uwGrt6Cc
	XXzUTqeYdEyGyZ9m1QBg2JyLZ1ASAsnaHRYScsyv5Y9jlalZWWlJLY7hJrp4sB91BAqMEE
	6mUPOBPmEuQcQFzvQrjtdXzb6rfr5eeJCcdYO+E8c6rPMqHKNORKhU1q3UsCtMhAvaYEEn
	qJCln8cIOfWVHZJz+RItDRti/DQMm7jRMIWeVoKJy5ABBGlnOQ5fe2HBow9dLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729195851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZt+XWadWsIegJ888x39wB3zAvBhXrCUUAGJ4erQzpI=;
	b=gkSYhkLn2xmQR7Gmaq+fwMOTbssW0cPAJJa9PsooU0bppZvI/H/EDvJC08aNqLTjB70B4r
	z/8Ln4veyiHDIXAw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Use atomic64_try_cmpxchg_relaxed() in
 get_inode_sequence_number()
Cc: Uros Bizjak <ubizjak@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 andrealmeid@igalia.com, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010071023.21913-2-ubizjak@gmail.com>
References: <20241010071023.21913-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172919585078.1442.8524813422073835687.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     87347f148061b48c3495fb61dcbad384760da9cf
Gitweb:        https://git.kernel.org/tip/87347f148061b48c3495fb61dcbad384760=
da9cf
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 10 Oct 2024 09:10:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Oct 2024 22:02:27 +02:00

futex: Use atomic64_try_cmpxchg_relaxed() in get_inode_sequence_number()

Optimize get_inode_sequence_number() to use simpler and faster:

  !atomic64_try_cmpxchg_relaxed(*ptr, &old, new)

instead of:

  atomic64_cmpxchg relaxed(*ptr, old, new) !=3D old

The x86 CMPXCHG instruction returns success in ZF flag, so
this change saves a compare after cmpxchg. The generated
code improves from:

 3da:	31 c0                	xor    %eax,%eax
 3dc:	f0 48 0f b1 8a 38 01 	lock cmpxchg %rcx,0x138(%rdx)
 3e3:	00 00
 3e5:	48 85 c0             	test   %rax,%rax
 3e8:	48 0f 44 c1          	cmove  %rcx,%rax

to:

 3da:	31 c0                	xor    %eax,%eax
 3dc:	f0 48 0f b1 8a 38 01 	lock cmpxchg %rcx,0x138(%rdx)
 3e3:	00 00
 3e5:	48 0f 44 c1          	cmove  %rcx,%rax

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Link: https://lore.kernel.org/all/20241010071023.21913-2-ubizjak@gmail.com

---
 kernel/futex/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 3146730..692912b 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -185,8 +185,8 @@ static u64 get_inode_sequence_number(struct inode *inode)
 		if (WARN_ON_ONCE(!new))
 			continue;
=20
-		old =3D atomic64_cmpxchg_relaxed(&inode->i_sequence, 0, new);
-		if (old)
+		old =3D 0;
+		if (!atomic64_try_cmpxchg_relaxed(&inode->i_sequence, &old, new))
 			return old;
 		return new;
 	}

