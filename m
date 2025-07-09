Return-Path: <linux-tip-commits+bounces-6046-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C77AFE7EE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 13:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2445161C65
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 11:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C8F2C15B1;
	Wed,  9 Jul 2025 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u8/9tHlz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yZ9XNvbi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7CD28F93E;
	Wed,  9 Jul 2025 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061085; cv=none; b=ouwMBH2CLt80OMHN9uLVcemQ1rLda7RCXopCuhbJ8sBaQzF6/Kyn6lDv0w9/CC/+cY0MnAo0KrWmBy41yEUCwwt3/QytYO2pAtxpNzi4s4Pj1WNFKgCrP/7cSLXMwp/G6VspptYm0VUgE5IQK4VzrrH9PlGhYYY+U4vXG+P4ALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061085; c=relaxed/simple;
	bh=0HXZTf2+zftvPNshPrkGK7w5FUdfDehbYy8eoBGWk1M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V+IMsxITsjLRIlFD3iE4VU0PY0YEFNspKAaQ5D62VCSogZ0SNmoGTFGlvM+jxgaSGPnxEaoO9b+R0f9kWrgiCxKKGHo8icFeHPPs8MhWmpMqhWCNOTbTV7bvSMlQOOCaIr5MFLj+lvghnJ3jb79Hd5QelenvzxcDM4Hkchh1/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u8/9tHlz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yZ9XNvbi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 11:37:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752061080;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQ/FyDJSiGA6TA+ud5XGfY1EFfdC9QJcR+VoS1anZ9w=;
	b=u8/9tHlzSTSYHOnnm3ctrZiJcR5rGOV0HH8MFY4xzXK2bEbuWBoFZLAh41mljQmxFOtz7v
	pTwIpxsQaVFnyOSmNpeGG0B2kvMGVztJICO5wSiVWh03myroi7NLrA/0oVZuvS3D5cN1Dp
	JxiNzVo7fx1SW/Fm8XfPjxSLSE9mZ4omSp0FEQv5G7aOMHjYOctxI/8i3GlLHI4677xEXB
	741IaHTCLApKE6sYGdJAGov80H7V0l9AXTG2AM4GH8mS/gN9aDwUqKM9qYVAab8i4Ugb6I
	Rj62aZYOPPuDkXIpu6RcrfNzCdijOZ6mm2RC8SWj9kp1L+9aAuV5KCwLK95ueA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752061080;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQ/FyDJSiGA6TA+ud5XGfY1EFfdC9QJcR+VoS1anZ9w=;
	b=yZ9XNvbi8KYt9yE9DhxJO5+2CT8TQRnJGUNfrY4xalJX1Z7bTi/1QUL/BMXpN88riLrgM8
	RF66JFqeEh7Ys4Ag==
From: "tip-bot2 for Greg Kroah-Hartman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Move away from using a fake
 platform device
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <2025070121-omission-small-9308@gregkh>
References: <2025070121-omission-small-9308@gregkh>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175206107968.406.11106963441390730546.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     9b355cdb63b1e43434d7ac57430d3e68de58338d
Gitweb:        https://git.kernel.org/tip/9b355cdb63b1e43434d7ac57430d3e68de58338d
Author:        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
AuthorDate:    Tue, 01 Jul 2025 12:54:22 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 09 Jul 2025 13:12:08 +02:00

x86/microcode: Move away from using a fake platform device

Downloading firmware needs a device to hang off of, and so a platform device
seemed like the simplest way to do this.  Now that we have a faux device
interface, use that instead as this "microcode device" is not anything
resembling a platform device at all.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/2025070121-omission-small-9308@gregkh
---
 arch/x86/kernel/cpu/microcode/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index fe50eb5..b92e09a 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -17,8 +17,8 @@
 
 #define pr_fmt(fmt) "microcode: " fmt
 
-#include <linux/platform_device.h>
 #include <linux/stop_machine.h>
+#include <linux/device/faux.h>
 #include <linux/syscore_ops.h>
 #include <linux/miscdevice.h>
 #include <linux/capability.h>
@@ -249,7 +249,7 @@ static void reload_early_microcode(unsigned int cpu)
 }
 
 /* fake device for request_firmware */
-static struct platform_device	*microcode_pdev;
+static struct faux_device *microcode_fdev;
 
 #ifdef CONFIG_MICROCODE_LATE_LOADING
 /*
@@ -690,7 +690,7 @@ static int load_late_locked(void)
 	if (!setup_cpus())
 		return -EBUSY;
 
-	switch (microcode_ops->request_microcode_fw(0, &microcode_pdev->dev)) {
+	switch (microcode_ops->request_microcode_fw(0, &microcode_fdev->dev)) {
 	case UCODE_NEW:
 		return load_late_stop_cpus(false);
 	case UCODE_NEW_SAFE:
@@ -841,9 +841,9 @@ static int __init microcode_init(void)
 	if (early_data.new_rev)
 		pr_info_once("Updated early from: 0x%08x\n", early_data.old_rev);
 
-	microcode_pdev = platform_device_register_simple("microcode", -1, NULL, 0);
-	if (IS_ERR(microcode_pdev))
-		return PTR_ERR(microcode_pdev);
+	microcode_fdev = faux_device_create("microcode", NULL, NULL);
+	if (!microcode_fdev)
+		return -ENODEV;
 
 	dev_root = bus_get_dev_root(&cpu_subsys);
 	if (dev_root) {
@@ -862,7 +862,7 @@ static int __init microcode_init(void)
 	return 0;
 
  out_pdev:
-	platform_device_unregister(microcode_pdev);
+	faux_device_destroy(microcode_fdev);
 	return error;
 
 }

