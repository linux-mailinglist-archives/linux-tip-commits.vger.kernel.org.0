Return-Path: <linux-tip-commits+bounces-3518-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0915A39DD3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 14:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B545E162F47
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E1413DDB9;
	Tue, 18 Feb 2025 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ul/o6fEH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AqaeAla1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E73208;
	Tue, 18 Feb 2025 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885975; cv=none; b=k2Zk1kJXFr0ngmRasIYpjEL16NjaWijb3uD0Wl9Md/SsqAannkGQ8B1uSDPKey6z1UNh4hI7vRuZIk2EC3lQkzqgqYUvNACyL30TvBrQbIFqP32yQZd+Feoi1SwAVqkPmsFYwyBYwZAx38MmEcjUQitX6W4ArvxWCtWC7k823AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885975; c=relaxed/simple;
	bh=4aZFQRyNcuHGjYgpFRj5Ggul4g+o5DqQfEc9fBej+1A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Qk4VMD+TvjZbnZuOR0Ss7f3IjyZJDbe704joxC/VbUmQATCO0VSd8Li3w11INTuFti+JSocKLDxTrCgeWl5lq292Yayp5P3gIHikymF/OOoOYwEcEsmQaANkcAMRJ8UCnla6BabX1OFXG6xJ83MaGtfbx7JU7Vtltj5O8VaNtmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ul/o6fEH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AqaeAla1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 13:39:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739885966;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLwKPkAVbUS5KGtf6+OUJyrFeBygRv1lS3gLbewkoh8=;
	b=ul/o6fEH1KGloTXrnD2qR2hbf0WzqDmBKnsogX/MC45NPF9/ERvrj9RvVL0W1bwS2U2+zj
	Y5WD9BdL5M/c7u4w+p5xF8JXWZDwHckIUEsDFqhht3mFz8pWXqgVP/8qSo9cCLiKa/qU7x
	7mOfHcfQKFilt8sBcVmM288CQ7S3UDEQRv8GBc48N06x4CFECjkVrkfM+iw7iOPQsCQnt2
	LY2J9CcjF7x0x+YLkxgt7P0K9ZNrECqims8DN+GSpXXWQGWTw/OMc27LbwkquBNsrUyqrG
	tJdkAu6Qvhzfu8aoGbL0oMdJJmDhrwxACbK9dnxPVGeIyuy31MntSeBLnVz9QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739885966;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLwKPkAVbUS5KGtf6+OUJyrFeBygRv1lS3gLbewkoh8=;
	b=AqaeAla1HE9eTFAoawTMzi/ZE6iKwGXXs90MoXZdSjkBgtPEkGv3Czfc9MLHiZzNRvJLiT
	o26ebTqffNZxMDCg==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] x86/amd_node: Add support for debugfs access to SMN registers
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250130-wip-x86-amd-nb-cleanup-v4-3-b5cc997e471b@amd.com>
References: <20250130-wip-x86-amd-nb-cleanup-v4-3-b5cc997e471b@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988596320.10177.17094469239617982499.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     6b06755af6679fd7c98ebc017ac31c8a74127538
Gitweb:        https://git.kernel.org/tip/6b06755af6679fd7c98ebc017ac31c8a74127538
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Thu, 30 Jan 2025 19:48:57 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Feb 2025 10:09:56 +01:00

x86/amd_node: Add support for debugfs access to SMN registers

There are certain registers on AMD Zen systems that can only be accessed
through SMN.

Introduce a new interface that provides debugfs files for accessing SMN.  As
this introduces the capability for userspace to manipulate the hardware in
unpredictable ways, taint the kernel when writing.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250130-wip-x86-amd-nb-cleanup-v4-3-b5cc997e471b@amd.com
---
 arch/x86/kernel/amd_node.c |  99 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index ac57194..b670fa8 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -8,6 +8,7 @@
  * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
  */
 
+#include <linux/debugfs.h>
 #include <asm/amd_node.h>
 
 /*
@@ -192,6 +193,87 @@ int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write
 }
 EXPORT_SYMBOL_GPL(amd_smn_hsmp_rdwr);
 
+static struct dentry *debugfs_dir;
+static u16 debug_node;
+static u32 debug_address;
+
+static ssize_t smn_node_write(struct file *file, const char __user *userbuf,
+			      size_t count, loff_t *ppos)
+{
+	u16 node;
+	int ret;
+
+	ret = kstrtou16_from_user(userbuf, count, 0, &node);
+	if (ret)
+		return ret;
+
+	if (node >= amd_num_nodes())
+		return -ENODEV;
+
+	debug_node = node;
+	return count;
+}
+
+static int smn_node_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "0x%08x\n", debug_node);
+	return 0;
+}
+
+static ssize_t smn_address_write(struct file *file, const char __user *userbuf,
+				 size_t count, loff_t *ppos)
+{
+	int ret;
+
+	ret = kstrtouint_from_user(userbuf, count, 0, &debug_address);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static int smn_address_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "0x%08x\n", debug_address);
+	return 0;
+}
+
+static int smn_value_show(struct seq_file *m, void *v)
+{
+	u32 val;
+	int ret;
+
+	ret = amd_smn_read(debug_node, debug_address, &val);
+	if (ret)
+		return ret;
+
+	seq_printf(m, "0x%08x\n", val);
+	return 0;
+}
+
+static ssize_t smn_value_write(struct file *file, const char __user *userbuf,
+			       size_t count, loff_t *ppos)
+{
+	u32 val;
+	int ret;
+
+	ret = kstrtouint_from_user(userbuf, count, 0, &val);
+	if (ret)
+		return ret;
+
+	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+
+	ret = amd_smn_write(debug_node, debug_address, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+DEFINE_SHOW_STORE_ATTRIBUTE(smn_node);
+DEFINE_SHOW_STORE_ATTRIBUTE(smn_address);
+DEFINE_SHOW_STORE_ATTRIBUTE(smn_value);
+
 static int amd_cache_roots(void)
 {
 	u16 node, num_nodes = amd_num_nodes();
@@ -239,6 +321,15 @@ static int reserve_root_config_spaces(void)
 	return 0;
 }
 
+static bool enable_dfs;
+
+static int __init amd_smn_enable_dfs(char *str)
+{
+	enable_dfs = true;
+	return 1;
+}
+__setup("amd_smn_debugfs_enable", amd_smn_enable_dfs);
+
 static int __init amd_smn_init(void)
 {
 	int err;
@@ -259,6 +350,14 @@ static int __init amd_smn_init(void)
 	if (err)
 		return err;
 
+	if (enable_dfs) {
+		debugfs_dir = debugfs_create_dir("amd_smn", arch_debugfs_dir);
+
+		debugfs_create_file("node",	0600, debugfs_dir, NULL, &smn_node_fops);
+		debugfs_create_file("address",	0600, debugfs_dir, NULL, &smn_address_fops);
+		debugfs_create_file("value",	0600, debugfs_dir, NULL, &smn_value_fops);
+	}
+
 	return 0;
 }
 

