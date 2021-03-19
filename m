Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC276342861
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Mar 2021 23:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhCSWGR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Mar 2021 18:06:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39946 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhCSWFx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Mar 2021 18:05:53 -0400
Date:   Fri, 19 Mar 2021 22:05:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616191552;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QJThDCNo7fkHvbAFLjyOCFrm6AV3wYi52LiaHosYtU=;
        b=FpUHegFfPbdGBho+LaiK++CeGrTShXhPWykdexx3hsDvw9zw4ouHbn7kEkEC4YJdMT2AOn
        GzFuRFAPRppgce7+/G7JenFkl0xBAiol6Ixt4YgFKTNkZqrbf13b41/0IzFDMZuhdNiLRw
        YZh0wG+AQJ52OOFg5Gy/jiaCfDIySK+pmxCRhUeoMh6tGqGMk3ZrwIMBvfsNPCgIJ6hbon
        YIhesgR9TKb40y+wFUtRqX86mmT3EVeqE9XTyoSP14PGAuw1lJWbu5oE9flWSze6O6c+A5
        CmFROUF7GI8WZRiHUCjbg90l044AIdB4b3Cu4oD+ezxOpcQ5tU8yOlMesZu5Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616191552;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QJThDCNo7fkHvbAFLjyOCFrm6AV3wYi52LiaHosYtU=;
        b=ThxpNtrdG1PpitVQEHc4P+kdjm1YIxoTjA4R0iRhTDXuT+VHFv/ISdvOSX4vbYekcgaZes
        hrXO4TV07BIirpCQ==
From:   "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/apic/of: Fix CPU devicetree-node lookups
Cc:     Johan Hovold <johan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210312092033.26317-1-johan@kernel.org>
References: <20210312092033.26317-1-johan@kernel.org>
MIME-Version: 1.0
Message-ID: <161619155150.398.1617296870080727250.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     dd926880da8dbbe409e709c1d3c1620729a94732
Gitweb:        https://git.kernel.org/tip/dd926880da8dbbe409e709c1d3c1620729a94732
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Fri, 12 Mar 2021 10:20:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 19 Mar 2021 23:01:49 +01:00

x86/apic/of: Fix CPU devicetree-node lookups

Architectures that describe the CPU topology in devicetree and do not have
an identity mapping between physical and logical CPU ids must override the
default implementation of arch_match_cpu_phys_id().

Failing to do so breaks CPU devicetree-node lookups using of_get_cpu_node()
and of_cpu_device_node_get() which several drivers rely on. It also causes
the CPU struct devices exported through sysfs to point to the wrong
devicetree nodes.

On x86, CPUs are described in devicetree using their APIC ids and those
do not generally coincide with the logical ids, even if CPU0 typically
uses APIC id 0.

Add the missing implementation of arch_match_cpu_phys_id() so that CPU-node
lookups work also with SMP.

Apart from fixing the broken sysfs devicetree-node links this likely does
not affect current users of mainline kernels on x86.

Fixes: 4e07db9c8db8 ("x86/devicetree: Use CPU description from Device Tree")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210312092033.26317-1-johan@kernel.org
---
 arch/x86/kernel/apic/apic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index bda4f2a..4f26700 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2342,6 +2342,11 @@ static int cpuid_to_apicid[] = {
 	[0 ... NR_CPUS - 1] = -1,
 };
 
+bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
+{
+	return phys_id == cpuid_to_apicid[cpu];
+}
+
 #ifdef CONFIG_SMP
 /**
  * apic_id_is_primary_thread - Check whether APIC ID belongs to a primary thread
