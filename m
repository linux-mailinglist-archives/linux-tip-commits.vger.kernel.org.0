Return-Path: <linux-tip-commits+bounces-7776-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6F2CE809A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Dec 2025 20:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAEDB3002FE0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Dec 2025 19:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B939239E7D;
	Mon, 29 Dec 2025 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BX78xhOS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="02gxqLm4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C3B3BBF0;
	Mon, 29 Dec 2025 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035990; cv=none; b=YNxZA7TCJL5J3r0RWQWt85v8vnbcIdhX4EdGqpUM/rLqXWr8FqIkAuddyrcFhftwa75nwk/mSLy2K55GhanzF66N5VCNgFKvwbaSKGWNCbyKKC764x64UsMvXOxrG0xZXINw051qqNKJraKYFpl8xzeM+ML+w3GIwSpyagKWiJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035990; c=relaxed/simple;
	bh=i8g9ZdzJXAJZfwrTCFkBRz3py7xiGCw4fyQE/D0NuP4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g0X3K2pZUYYQU9T7BCPlQCZ5pD8foZNi+QYW5l10VtyJEvsDF05zKgk1krbFYqOPIIJUo/E8OANJ+/GZoW+h6u9w5fbmaG5QFsWGyZG+wQDPQ2et/DPWZY2E1pczrSNz8Z/rua2UA6m1tIqoK4JK14bJhaWT2IzuPt88aP3l2zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BX78xhOS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=02gxqLm4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Dec 2025 19:19:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767035986;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0lhwn9lYuoJRxz269wRDpvM61GMyiHaz0i3wSr7Tvo=;
	b=BX78xhOSr4PtuY4B9yYOwuTmSf/IpoVwoA+mz6TeDaDlFkgjEBDRJR+MNXJ56Du395beuY
	kzwd0BxwsDl+AgSdNoAHeWy7e4Y8QlLRVALvSHztNQqQZKIGUIPvuA734rwxFmvYdZGK+4
	3hEltJEs3WWVU86rLoO6zmoh5RVx4z3kfX5zAWo3KVl2gBY1ykRfRccKxrjOnlBybnoO2K
	1yDAqZPi8QfNXZdCPeUe1BeDzs4jqn7Lnc0M5DdWMda/36y5QeD4xSkQ5vnmDj77UpbLUX
	q4CmBj0lN4KdvhCnKQytbb+M2Pu+CWca0r5Xl2+wze04mYF3N8rYKGvPvug84w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767035986;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0lhwn9lYuoJRxz269wRDpvM61GMyiHaz0i3wSr7Tvo=;
	b=02gxqLm44ZghP/Oh9NysvsB5pxciCCiv5nzz9CG9sdZDFwIfTrntBrDgykhR10SUTADp7V
	SyYH+3Kb6Lc1+gCw==
From: "tip-bot2 for Rong Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/microcode/AMD: Fix Entrysign revision check for
 Zen5/Strix Halo
Cc: Rong Zhang <i@rong.moe>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 stable@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251229182245.152747-1-i@rong.moe>
References: <20251229182245.152747-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176703598526.510.8616302363173639584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     150b1b97e27513535dcd3795d5ecd28e61b6cb8c
Gitweb:        https://git.kernel.org/tip/150b1b97e27513535dcd3795d5ecd28e61b=
6cb8c
Author:        Rong Zhang <i@rong.moe>
AuthorDate:    Tue, 30 Dec 2025 02:22:21 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Dec 2025 20:08:02 +01:00

x86/microcode/AMD: Fix Entrysign revision check for Zen5/Strix Halo

Zen5 also contains family 1Ah, models 70h-7Fh, which are mistakenly missing
from cpu_has_entrysign(). Add the missing range.

Fixes: 8a9fb5129e8e ("x86/microcode/AMD: Limit Entrysign signature checking t=
o known generations")
Signed-off-by: Rong Zhang <i@rong.moe>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@kernel.org
Link: https://patch.msgid.link/20251229182245.152747-1-i@rong.moe
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microc=
ode/amd.c
index 3821a98..4667353 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -258,7 +258,7 @@ static bool cpu_has_entrysign(void)
 	if (fam =3D=3D 0x1a) {
 		if (model <=3D 0x2f ||
 		    (0x40 <=3D model && model <=3D 0x4f) ||
-		    (0x60 <=3D model && model <=3D 0x6f))
+		    (0x60 <=3D model && model <=3D 0x7f))
 			return true;
 	}
=20

