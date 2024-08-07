Return-Path: <linux-tip-commits+bounces-1977-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B333394AE07
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 18:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B037DB21EE0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 16:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E3413B7AF;
	Wed,  7 Aug 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rhcLLtlT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5UyP7OTf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E13139D07;
	Wed,  7 Aug 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047930; cv=none; b=uPsW+qQnxnKs3FIkRGaEjtnsQrN8Md5GYR3kpFoE5gm6PB9ZPQiaUCUbH+LB9y6s4ep2LlJwNnazealGvbNTzQ3qJQpyUiFWlPS50DtJKLMJfMHneF28VfbFCe2EHPQAW6er139sYOgqNbWOxY/EMgvfh8v607IR0lEuVA/PozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047930; c=relaxed/simple;
	bh=IPu+tcZlfKOvBSyzpGBTSTiStdFZEkoLQRMj3saJHwk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tymNlVbL2Lwf49ZI1hXJpOARh6ImLp9F/aHaCs/mIV7qyKmOCy7KQOg3fZgksiBdJZANFUGgwI8BFTyvptTsHTVEHxwS9LDv4eDPrHgUgUMM7Y37vfDr9kU2WEkKDORfIrg97CCVaDa+fxDjIGWgHwHCae0hWB4YfiSpVouvc0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rhcLLtlT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5UyP7OTf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 16:25:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723047927;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wIdPRcHk3eloN7gx1cFfpAQ8Ny5nz0JoibLOSc5hko=;
	b=rhcLLtlTXc+wcw1f/D3i8jktZKYMAB9ioAzDQSDbXBOc3DweGtSi0wEkse5fXCsSAzNBk8
	Dlhbgir1WA9PuqmyEB1NrEKHphrciP4g0N65mGCtdyKPvKha+1UfgpVyG2X5tF7aB4FVdQ
	LJ1K2XRNq6PDNcWw8gwRkFZ3tSS8N3MIFpHcxaiGnCQuHDIZsruIHYJTBkoORo1kT/p0Fs
	CkBsUug2BDHzt7pgrveADM2Z8f52UX9TTCkOuYh3D9hWlyhq3tSAFCCg8LTf8qhV4s22r0
	T7ZlCj9yS+hR3glFN0RMAcMM/djU3+g+c4NQkpk95nMHaSz/XXUxNB4LNj270g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723047927;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wIdPRcHk3eloN7gx1cFfpAQ8Ny5nz0JoibLOSc5hko=;
	b=5UyP7OTfh/t9Wt3NdLaY5JECnvCQ6FaxdKmhVStTIW/LSLxMsTiCezgkpc6P/+PKW+Jba2
	Sho1wHYDrfkJvDCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/ioapic: Move replace_pin_at_irq_node() to the call site
Cc: Thomas Gleixner <tglx@linutronix.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Breno Leitao <leitao@debian.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802155440.906636514@linutronix.de>
References: <20240802155440.906636514@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172304792702.2215.15469259240448673717.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     ee64510fb959991c3afd94e05e468a5b27e77f68
Gitweb:        https://git.kernel.org/tip/ee64510fb959991c3afd94e05e468a5b27e77f68
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 02 Aug 2024 18:15:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 18:13:28 +02:00

x86/ioapic: Move replace_pin_at_irq_node() to the call site

It's only used by check_timer().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/all/20240802155440.906636514@linutronix.de

---
 arch/x86/kernel/apic/io_apic.c | 40 ++++++++++++++-------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 3669b5d..51ecfb5 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -370,28 +370,6 @@ static void __remove_pin_from_irq(struct mp_chip_data *data, int apic, int pin)
 		}
 }
 
-/*
- * Reroute an IRQ to a different pin.
- */
-static void __init replace_pin_at_irq_node(struct mp_chip_data *data, int node,
-					   int oldapic, int oldpin,
-					   int newapic, int newpin)
-{
-	struct irq_pin_list *entry;
-
-	for_each_irq_pin(entry, data->irq_2_pin) {
-		if (entry->apic == oldapic && entry->pin == oldpin) {
-			entry->apic = newapic;
-			entry->pin = newpin;
-			/* every one is different, right? */
-			return;
-		}
-	}
-
-	/* old apic/pin didn't exist, so just add new ones */
-	add_pin_to_irq_node(data, node, newapic, newpin);
-}
-
 static void io_apic_modify_irq(struct mp_chip_data *data, bool masked,
 			       void (*final)(struct irq_pin_list *entry))
 {
@@ -2067,6 +2045,24 @@ static int __init mp_alloc_timer_irq(int ioapic, int pin)
 	return irq;
 }
 
+static void __init replace_pin_at_irq_node(struct mp_chip_data *data, int node,
+					   int oldapic, int oldpin,
+					   int newapic, int newpin)
+{
+	struct irq_pin_list *entry;
+
+	for_each_irq_pin(entry, data->irq_2_pin) {
+		if (entry->apic == oldapic && entry->pin == oldpin) {
+			entry->apic = newapic;
+			entry->pin = newpin;
+			return;
+		}
+	}
+
+	/* Old apic/pin didn't exist, so just add a new one */
+	add_pin_to_irq_node(data, node, newapic, newpin);
+}
+
 /*
  * This code may look a bit paranoid, but it's supposed to cooperate with
  * a wide range of boards and BIOS bugs.  Fortunately only the timer IRQ

