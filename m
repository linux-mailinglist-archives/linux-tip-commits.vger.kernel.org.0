Return-Path: <linux-tip-commits+bounces-3381-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE5FA37D7D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Feb 2025 09:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674243A8E3F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Feb 2025 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A74A1A5B8E;
	Mon, 17 Feb 2025 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a+bJN/vV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UFolICx7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFA919EEBD;
	Mon, 17 Feb 2025 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782320; cv=none; b=nannFJItN1kM6VEkRdEZstQU3QOpxO9Gjfh8v6fxay8NbldaIfzW9/O9OhSf8TAwtQRWdXd+xwOmn4eqdnctmnmYvO56rwRZwBDDl8V9rj6VqQIar88UjI7h2nXgBU3KWlPBngPhRSZ6CeyPG+ccvrn0AT1N1mM+7j5HKtRa8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782320; c=relaxed/simple;
	bh=mkiJ96UHseTE5jskAij7NUvt7qtFcUL504yNQipCynA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IgdtuXcezjTXz6cdopMIKea9V2YxabsyAVT6Q+Zx7YsW/6JpwDQAmtimHGJL9c/lxqx3vpHkGqbLBw/iZ5yh9AeMpQKnJMxYmyDNjfDP9GLPU1qWHNPUCwzDGhDehZ+lDGjo9WXhH5RtZ/0rLYyoph7tV6Lx6GAmTBV1LHpkDjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a+bJN/vV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UFolICx7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Feb 2025 08:51:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739782315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cyak+Y+fd5s+doCvc3Z7QHi0FZ/Yeh7Z+nhmtSc4Hv8=;
	b=a+bJN/vVxAfpSpMfOPNrgZAzzikOblJiHbCpQyAIQ4Bvh+d2EizDjoCun84z9Z0pDwR0PK
	yfeD2k8pgO5Yoyf6aL0Na9vroebj6CZ3zveZeAwnVLX4t/z2TvkcSdsr8hOXXK9hG1TWQL
	lD+SvEiXF5WQusDq/gstoaWSB6tWSNoOQd/RcQd8ePMFccso6DM7l0wC+clQfFVqDENjkv
	X+fL2DC9I4iRIj9julrMo9Pi3hbHsK+W17jq3AnMLsbL2zPx9AdQKSoc/9EPtsEMFzyjf+
	6nTKquOV4YQqiW1vuGgYZFfUL5mMORJb8WnJoy1hsb01uUDF7C4hf5jSa8YK1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739782315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cyak+Y+fd5s+doCvc3Z7QHi0FZ/Yeh7Z+nhmtSc4Hv8=;
	b=UFolICx7VnxOqT4BWfQCzMlHtu7F9XvjOjEJmU+iAJi0wjzvpz7O8imy/Rs6dxAoW3+m69
	EaFk2cv8l52zu6Bw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Remove unused
 save_microcode_in_initrd_amd() declarations
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250211163648.30531-3-bp@kernel.org>
References: <20250211163648.30531-3-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173978231515.10177.15581223977606985908.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     3ef0740d10b005a45e8ae5b4b7b5d37bfddf63c0
Gitweb:        https://git.kernel.org/tip/3ef0740d10b005a45e8ae5b4b7b5d37bfddf63c0
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 23 Jan 2025 12:23:47 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Feb 2025 09:42:31 +01:00

x86/microcode/AMD: Remove unused save_microcode_in_initrd_amd() declarations

Commit

  a7939f016720 ("x86/microcode/amd: Cache builtin/initrd microcode early")

renamed it to save_microcode_in_initrd() and made it static. Zap the
forgotten declarations.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20250211163648.30531-3-bp@kernel.org
---
 arch/x86/kernel/cpu/microcode/amd.c      | 2 +-
 arch/x86/kernel/cpu/microcode/internal.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 4a62625..f831c06 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -517,7 +517,7 @@ static bool __apply_microcode_amd(struct microcode_amd *mc, unsigned int psize)
  * patch container file in initrd, traverse equivalent cpu table, look for a
  * matching microcode patch, and update, all in initrd memory in place.
  * When vmalloc() is available for use later -- on 64-bit during first AP load,
- * and on 32-bit during save_microcode_in_initrd_amd() -- we can call
+ * and on 32-bit during save_microcode_in_initrd() -- we can call
  * load_microcode_amd() to save equivalent cpu table and microcode patches in
  * kernel heap memory.
  *
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 21776c5..5df6217 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -100,14 +100,12 @@ extern bool force_minrev;
 #ifdef CONFIG_CPU_SUP_AMD
 void load_ucode_amd_bsp(struct early_load_data *ed, unsigned int family);
 void load_ucode_amd_ap(unsigned int family);
-int save_microcode_in_initrd_amd(unsigned int family);
 void reload_ucode_amd(unsigned int cpu);
 struct microcode_ops *init_amd_microcode(void);
 void exit_amd_microcode(void);
 #else /* CONFIG_CPU_SUP_AMD */
 static inline void load_ucode_amd_bsp(struct early_load_data *ed, unsigned int family) { }
 static inline void load_ucode_amd_ap(unsigned int family) { }
-static inline int save_microcode_in_initrd_amd(unsigned int family) { return -EINVAL; }
 static inline void reload_ucode_amd(unsigned int cpu) { }
 static inline struct microcode_ops *init_amd_microcode(void) { return NULL; }
 static inline void exit_amd_microcode(void) { }

