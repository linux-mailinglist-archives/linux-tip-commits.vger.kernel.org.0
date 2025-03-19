Return-Path: <linux-tip-commits+bounces-4367-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A3DA68AC5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A907AC84D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F07E25D53A;
	Wed, 19 Mar 2025 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EylSePQW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W2sPgfsy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0899825CC6D;
	Wed, 19 Mar 2025 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382237; cv=none; b=Eu37dROFcjpLaPftn0lrHMT1oTgxCFR6RDfIFq+Iak72KnK+myvUjf5JSe0ucKTvjTHGHKBNvsXhH5/j48F8LQ1oh+CoUWYz87wEsugABSxkCeyenD7Kja90eJKE4X09i3dZuETyvRuMOHQdUWCB/7C8pQk+3C7LWnpDaLO9ZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382237; c=relaxed/simple;
	bh=7SXGMEj8ntnRHwzQ9if4v2JPI/DdPoxxHFOsy8TvSKc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qPbzlnUb45d+creRxJHzjQFKnIPhWUmpokfM4AR78S3vIFonqIQGXO0iuLUt/9C0JxsJylOKQ17VaZqH74ah3cADs2L7RLPnzpv/kk6wh3Ub2rRmWTVCYbMrEGuzjIcTpAimgqKErS5phPuLPO8gSlzhaqm59THFYUtwq/oiskU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EylSePQW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W2sPgfsy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNU8HJMX96zayZ8wzwRgglI8MG69Z0KRktZqoCfCJ2s=;
	b=EylSePQWd3kxI+2ytktT4iqiBMvJBlYPUsrjCENfGaX/ZgxgsM0tcSfjkV0EZ1GscwB5nW
	cRRJ6L/jEWgGBZT558STOiq537v8QwnF/DhAAC6ktS2WkQhR5Y5QSdICWNVliMSVbx+MJy
	OrhLtiNfqIxWDwcWuo0PqTou5doiOKU/H86HZMCO81fgt95+xd5OV7boXZ0o59lbrHSAHJ
	9qT+XnTB3BqEbjKz1kpBXWu0A6lNg1DoBLqzz8I+M7qAz0RW0C4F5YVLofvimmK69hjD9i
	XdWrWJg0kJE7+PlTmj9M0Rth+Da44V5b66zITj8OPPbjt3vb4uCIadAMsq07Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNU8HJMX96zayZ8wzwRgglI8MG69Z0KRktZqoCfCJ2s=;
	b=W2sPgfsy0TJPdV8AusD9+DGsHhQORlTr/ICiut37hYuZMK+ebeiGtkRAlU/sC/VxG2a2HX
	sCRXafBhL4oqJlBw==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/amd_node: Add support for debugfs access to SMN registers
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250130-wip-x86-amd-nb-cleanup-v4-3-b5cc997e471b@amd.com>
References: <20250130-wip-x86-amd-nb-cleanup-v4-3-b5cc997e471b@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238223204.14745.16402008278992919220.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     9c19cc1f5f571b03cc56338ed12836531a4989a4
Gitweb:        https://git.kernel.org/tip/9c19cc1f5f571b03cc56338ed12836531a4989a4
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Thu, 30 Jan 2025 19:48:57 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:18:33 +01:00

x86/amd_node: Add support for debugfs access to SMN registers

There are certain registers on AMD Zen systems that can only be accessed
through SMN.

Introduce a new interface that provides debugfs files for accessing SMN.  As
this introduces the capability for userspace to manipulate the hardware in
unpredictable ways, taint the kernel when writing.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
 

