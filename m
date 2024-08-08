Return-Path: <linux-tip-commits+bounces-2018-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8C194C17A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76CEFB2A6BF
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CDD18FDB4;
	Thu,  8 Aug 2024 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VNWfpw/8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vJTXkqMc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E6F18F2D6;
	Thu,  8 Aug 2024 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131150; cv=none; b=aFPUEG//WP0+OWQstrgtjRNJV43qpwzFWSRI2C9hlS0CH9tquv1G48QjlK2jD83/gs7+/NexDl/FqAE0LIAqoAGU7bZie7TIobS/GwRew0Cjij6PANkfyOP6lYjCRhsmnEIMsm/7ercsZZBiaAuIXhdmYFuaOHu5eIrZo0xNRec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131150; c=relaxed/simple;
	bh=Sjzq6+JOVvcy+fpe61lsvDx1mzbU5Wg/OLPWO8z93Kc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Kazm05ouUo7rlkcSgByf8Ue+H8nVmJXQkxCaCylwq+b0e/0M6uML2Y1UU3kBAeH8ZR2NSiZCA8H0OvWUXK8ya9hyE6QXET969kitcPMRMXn9RXKtNI4aUJ1phGoIJ0B3u2KdHBBDcUpYMDdF+pvJbe4rIIcE6B/XtUToicrwl1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VNWfpw/8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vJTXkqMc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:32:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723131147;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOHNFV5sBHJdGtUesrN2xQFLTvZVCLxkMk8vu/3eHds=;
	b=VNWfpw/8OESrfQb7zu+cHkNPkxjt156YwDByiFCrhtxF3BAviqHR/iuvBrllUdJ/ah9Xnq
	F6QqpiNO0V8cTJ73DcPTRTcrYp0EQYVLa1jH7hqazQW7j/vesrYA2h/x5XwdlMd1p63hy+
	bu2oT3v5UtJRyl0f80yf9E7pZAdqEc2LuuuQL7aRlzppJvArvBQhJiaLMvH2RZ7JYKOqkj
	EVcAKEmg6qr9EdwZ9rddp+mJS8b4p2FVzHJNKCut1pdPzbR/49eFjosFfkNDINmyDDBtTr
	X6gfm59eFMrZB/BFGD/jUjE42Q3XT21i/JT5P6fw2loAdzPeBbu7P6Ry5gyznA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723131147;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOHNFV5sBHJdGtUesrN2xQFLTvZVCLxkMk8vu/3eHds=;
	b=vJTXkqMcH1SYieuKCbh+Q623wVpSvocdD2d2zSPtxrZj47jfEkxsMIHrFsyTBTTWOwesC5
	Q6zCfVD8yAxS/2BQ==
From: "tip-bot2 for Li RongQing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Don't print out SRAT table information
Cc: Li RongQing <lirongqing@baidu.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240806120823.17111-1-lirongqing@baidu.com>
References: <20240806120823.17111-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313114640.2215.16753789471531681179.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     830a0d12943f53077b235f2a3caa8ab2b36475a3
Gitweb:        https://git.kernel.org/tip/830a0d12943f53077b235f2a3caa8ab2b36475a3
Author:        Li RongQing <lirongqing@baidu.com>
AuthorDate:    Tue, 06 Aug 2024 20:08:23 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:23:40 +02:00

x86/mm: Don't print out SRAT table information

This per CPU log is becoming longer with more and more CPUs in system,
which slows down the boot process due to the serializing nature of
printk().

The value of this information is dubious and it can be retrieved by lscpu
from user space if required..

Downgrade the printk() to pr_debug() so it is still accessible for debug
purposes.

[ tglx: Massaged changelog ]

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240806120823.17111-1-lirongqing@baidu.com

---
 arch/x86/mm/srat.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 9c52a95..6f8e0f2 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -57,8 +57,7 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 	}
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
-	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%04x -> Node %u\n",
-	       pxm, apic_id, node);
+	pr_debug("SRAT: PXM %u -> APIC 0x%04x -> Node %u\n", pxm, apic_id, node);
 }
 
 /* Callback for Proximity Domain -> LAPIC mapping */
@@ -98,8 +97,7 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
-	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%02x -> Node %u\n",
-	       pxm, apic_id, node);
+	pr_debug("SRAT: PXM %u -> APIC 0x%02x -> Node %u\n", pxm, apic_id, node);
 }
 
 int __init x86_acpi_numa_init(void)

