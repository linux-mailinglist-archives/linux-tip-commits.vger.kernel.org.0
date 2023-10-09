Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6697BDBF1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Oct 2023 14:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376365AbjJIMaS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 9 Oct 2023 08:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376470AbjJIMaC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 9 Oct 2023 08:30:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37ED10B;
        Mon,  9 Oct 2023 05:29:56 -0700 (PDT)
Date:   Mon, 09 Oct 2023 12:29:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696854595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fSBwPPuYTEKMKf339cHrJEKhRr6JzbrWL6jhZW7JOqU=;
        b=chLe2qC+V5FptQb70dLL6BZzCWEBYt4FWxNpnNwHIhQ2wM3rlHA2VpkN/0unTIkG/CoWvB
        KJ8Eyy5JgQ4moI5S6jrNWngy81hngsKa/uQeMIkJZ5W4RznJMtSZ2HT8tJQc6CHWoJtRQ8
        76P7Sz+cvrtdtC2kmwnMW+YwVQ1WGm4InoT7WbiC+/XuTJa4AZVbt5uU9Zjx8WNIrj8raq
        BaDn18ZwgDjJ7IWNM9CTFdNdz3wMytbxwzO9iJUAVlaCXM7gmo5kSffXiKUM0Xi4dMOdEJ
        AgsL7wy9vptNoX3bjsmEXq8P6VINGER5BQkEFHWcpsV6BCXcDx+TLxcI3L2evA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696854595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fSBwPPuYTEKMKf339cHrJEKhRr6JzbrWL6jhZW7JOqU=;
        b=nZJXKM1Wm5ktKnhSeXDCwVLk/R624mW7L8BVMrcAuZjjkIkXrMqjT4KdGrOirDH2754xvx
        555pT2f8Ngj/tNCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Simplify and rename
 generic_load_microcode()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115902.330295409@linutronix.de>
References: <20231002115902.330295409@linutronix.de>
MIME-Version: 1.0
Message-ID: <169685459487.3135.1600341788116234467.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     6dea0b60b5b3f7d810877d1d0ccf3778bb142d00
Gitweb:        https://git.kernel.org/tip/6dea0b60b5b3f7d810877d1d0ccf3778bb142d00
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:40 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 02 Oct 2023 18:31:20 +02:00

x86/microcode/intel: Simplify and rename generic_load_microcode()

so it becomes less obfuscated and rename it because there is nothing
generic about it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115902.330295409@linutronix.de
---
 arch/x86/kernel/cpu/microcode/intel.c | 47 +++++++++-----------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 24dd483..60862f6 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -240,19 +240,6 @@ int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type)
 }
 EXPORT_SYMBOL_GPL(intel_microcode_sanity_check);
 
-/*
- * Returns 1 if update has been found, 0 otherwise.
- */
-static int has_newer_microcode(void *mc, unsigned int csig, int cpf, int new_rev)
-{
-	struct microcode_header_intel *mc_hdr = mc;
-
-	if (mc_hdr->rev <= new_rev)
-		return 0;
-
-	return intel_find_matching_signature(mc, csig, cpf);
-}
-
 static void save_microcode_patch(void *data, unsigned int size)
 {
 	struct microcode_header_intel *p;
@@ -561,14 +548,12 @@ out:
 	return ret;
 }
 
-static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
+static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	unsigned int curr_mc_size = 0, new_mc_size = 0;
-	enum ucode_state ret = UCODE_OK;
-	int new_rev = uci->cpu_sig.rev;
+	int cur_rev = uci->cpu_sig.rev;
 	u8 *new_mc = NULL, *mc = NULL;
-	unsigned int csig, cpf;
 
 	while (iov_iter_count(iter)) {
 		struct microcode_header_intel mc_header;
@@ -585,6 +570,7 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 			pr_err("error! Bad data in microcode data file (totalsize too small)\n");
 			break;
 		}
+
 		data_size = mc_size - sizeof(mc_header);
 		if (data_size > iov_iter_count(iter)) {
 			pr_err("error! Bad data in microcode data file (truncated file?)\n");
@@ -607,16 +593,17 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 			break;
 		}
 
-		csig = uci->cpu_sig.sig;
-		cpf = uci->cpu_sig.pf;
-		if (has_newer_microcode(mc, csig, cpf, new_rev)) {
-			vfree(new_mc);
-			new_rev = mc_header.rev;
-			new_mc  = mc;
-			new_mc_size = mc_size;
-			mc = NULL;	/* trigger new vmalloc */
-			ret = UCODE_NEW;
-		}
+		if (cur_rev >= mc_header.rev)
+			continue;
+
+		if (!intel_find_matching_signature(mc, uci->cpu_sig.sig, uci->cpu_sig.pf))
+			continue;
+
+		vfree(new_mc);
+		cur_rev = mc_header.rev;
+		new_mc  = mc;
+		new_mc_size = mc_size;
+		mc = NULL;
 	}
 
 	vfree(mc);
@@ -636,9 +623,9 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 	save_microcode_patch(new_mc, new_mc_size);
 
 	pr_debug("CPU%d found a matching microcode update with version 0x%x (current=0x%x)\n",
-		 cpu, new_rev, uci->cpu_sig.rev);
+		 cpu, cur_rev, uci->cpu_sig.rev);
 
-	return ret;
+	return UCODE_NEW;
 }
 
 static bool is_blacklisted(unsigned int cpu)
@@ -687,7 +674,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device)
 	kvec.iov_base = (void *)firmware->data;
 	kvec.iov_len = firmware->size;
 	iov_iter_kvec(&iter, ITER_SOURCE, &kvec, 1, firmware->size);
-	ret = generic_load_microcode(cpu, &iter);
+	ret = parse_microcode_blobs(cpu, &iter);
 
 	release_firmware(firmware);
 
