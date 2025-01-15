Return-Path: <linux-tip-commits+bounces-3236-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7DEA11D61
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD7E3A2D2D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F14246A03;
	Wed, 15 Jan 2025 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hQDB9bKB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xKfOVbMd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E0C1FCFC5;
	Wed, 15 Jan 2025 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932675; cv=none; b=snyP1Ql037h/P4BVxiYfjy59WmWPVuwJCD2dyEG4jwVV4fo33FR/8cF1Nz1+AOVIBfk/ZbZ9zxZqht4srETiOGBVicEZL00RQ8y2VRLlty+QH5LqEjZErDesiWrWYj2n2gr6v4rcYFaQfv+vmMuo45rUrNjZIXxBBhR8oX+3U38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932675; c=relaxed/simple;
	bh=J5YWGZ01yeqXdXY0RBRtKpTGftV/sCGxIpK0TsNRS70=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jMCZvjRIXeE3ZwHk5F+CVfPFaCJ9KRlatCfLtZHpQw9XAoB9/3ScTE6qCTap9XNcMkyPcgdF0WCmjClJOxdFJLoy8uW9HXkco+xT+qFV9zEUSzVmfuGHfyNS+cGFKnDYGGpZCnQFIxPFCEnislKSSVD2EuJvbWRwOQOZyPGD8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hQDB9bKB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xKfOVbMd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qeukUA1S3nG9NT3WqgfZbZ/Q0lrwqZ264T8IoBsr20=;
	b=hQDB9bKB5EVyhT/3737PWZPrPJ7l4aEs1rIfdhlRvl2J/RRaHPGP89MIXXQu9JgAX6WKdh
	0vSg5Nc28yrMNRimElPG2SFiHd6kjxfM2OJFhG/aQ/KpNXg/Zqjrs+YkrtTiFT1iOcJbRM
	eUXKcrJdRPhCU+pq3ZeCFsIe8oZER6Dc38m7pJYsEuXSmixYa+Jc6EingVcjjA5b4bcwrD
	bPxJMBfPH9n3Gzk5vFFBAIFLJaJ9IyjUttFTdCkwZwhBonYerDcJ0Nq7W6GD/aXkIv1Mkm
	p1VZF4otzpE2/gctCrGNEezTgmDQpdOp57AK4Yaxg/XHihcq8i5cokmeUhh2bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qeukUA1S3nG9NT3WqgfZbZ/Q0lrwqZ264T8IoBsr20=;
	b=xKfOVbMdBH+bv8YpOmwNOnXbtoBCIpoCwIbiy6r1Wk+ulb49GAj0YX25YtFlJ75YftQOf/
	BFvttbcc1lCO1pBw==
From: "tip-bot2 for Rafael J. Wysocki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] kexec_core: Add and update comments regarding the
 KEXEC_JUMP flow
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 David Woodhouse <dwmw@amazon.co.uk>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250109140757.2841269-8-dwmw2@infradead.org>
References: <20250109140757.2841269-8-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693267180.31546.17490565091306081669.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     dc6ffa6cd52d2cd8fa25b25e42c80faf17f5fe33
Gitweb:        https://git.kernel.org/tip/dc6ffa6cd52d2cd8fa25b25e42c80faf17f5fe33
Author:        Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate:    Thu, 09 Jan 2025 14:04:19 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 14 Jan 2025 13:03:34 +01:00

kexec_core: Add and update comments regarding the KEXEC_JUMP flow

The KEXEC_JUMP flow is analogous to hibernation flows occurring before
and after creating an image and before and after jumping from the
restore kernel to the image one, which is why it uses the same device
callbacks as those hibernation flows.

Add comments explaining that to the code in question and update an
existing comment in it which appears a bit out of context.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250109140757.2841269-8-dwmw2@infradead.org
---
 kernel/kexec_core.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c0caa14..b424a5c 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1001,6 +1001,12 @@ int kernel_kexec(void)
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
+		/*
+		 * This flow is analogous to hibernation flows that occur
+		 * before creating an image and before jumping from the
+		 * restore kernel to the image one, so it uses the same
+		 * device callbacks as those two flows.
+		 */
 		pm_prepare_console();
 		error = freeze_processes();
 		if (error) {
@@ -1011,12 +1017,10 @@ int kernel_kexec(void)
 		error = dpm_suspend_start(PMSG_FREEZE);
 		if (error)
 			goto Resume_console;
-		/* At this point, dpm_suspend_start() has been called,
-		 * but *not* dpm_suspend_end(). We *must* call
-		 * dpm_suspend_end() now.  Otherwise, drivers for
-		 * some devices (e.g. interrupt controllers) become
-		 * desynchronized with the actual state of the
-		 * hardware at resume time, and evil weirdness ensues.
+		/*
+		 * dpm_suspend_end() must be called after dpm_suspend_start()
+		 * to complete the transition, like in the hibernation flows
+		 * mentioned above.
 		 */
 		error = dpm_suspend_end(PMSG_FREEZE);
 		if (error)
@@ -1052,6 +1056,13 @@ int kernel_kexec(void)
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
+		/*
+		 * This flow is analogous to hibernation flows that occur after
+		 * creating an image and after the image kernel has got control
+		 * back, and in case the devices have been reset or otherwise
+		 * manipulated in the meantime, it uses the device callbacks
+		 * used by the latter.
+		 */
 		syscore_resume();
  Enable_irqs:
 		local_irq_enable();

