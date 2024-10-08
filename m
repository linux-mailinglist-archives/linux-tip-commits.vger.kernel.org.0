Return-Path: <linux-tip-commits+bounces-2381-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB9F995212
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 16:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19261C24AB7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771071DFE36;
	Tue,  8 Oct 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="acmaMsD5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NAejuk56"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9004F1DFE16;
	Tue,  8 Oct 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398432; cv=none; b=bcVl8wCTWBrzN0GSN/iR5mJ+JSpt6byOyQlqcq9ZixRIxzKCdN8AmRbASY/kl6gW8BYwIZjAUHITS1a2m9JsOIK5cKcdpXeaxzrxXDBJ6V9k06gCEgOPFUrP/EBVt7kafajryshrZpnPUhMb5FWQvcy7+xuRaYG+6KkhYwrB344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398432; c=relaxed/simple;
	bh=MTgv2/V5IIObLqi6ZxA8yQbSrMu7SYBhJsn1BA4rhXU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=GvaBHJnMQoxxWa/NRh3XQRyZ7uWyqjuFaT7qva68xZqceLh1qayrOosBTqQjfu9x9JM3cJ/0Fnarrv+d+qfh/Ac1e/h9JwnKn6Ol2mLWHL2j4bQE3WTpH1DAUJ3FAdQtdf7qco7X5s4VVNTw6BqKxnCpTRipNjhY1WItIIR1idM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=acmaMsD5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NAejuk56; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 14:40:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728398428;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=F5bLJyh9ZkJ68/CCbZdAKB5GiDdPUq6aU/dY/O6tiJw=;
	b=acmaMsD5P0LdSxL4gsNm9gRl7UfF6zrhe3ZwtqL5aH0SPlarZ599utE4MUaFXLsHgOoAJH
	vUvXhGg6Gr+5ElVQWPLOXcjwV/0A5CKsD9a7btJF8n4TeL73rtkb/Kbl7CRHPuskbN02WT
	fYRJxFRM5eAGCbOs2j7WhQeKPXiy6pFFYr5NSGLLBOVTJIyRHJeQHyGvCKTfyxGVLSHO1H
	BO/mDjHmcobN7BbC67wXGPRfy3+5RSt1TZ4hJEYE2AzHFRKl0JO4RG5KbdOVJC3w3YmsXh
	Lmmk1/4zckY2RkqGQaFZ74K8tNs0Ja2goywDdTvNnn0yT1Wj2ynmNTHg6hADoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728398428;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=F5bLJyh9ZkJ68/CCbZdAKB5GiDdPUq6aU/dY/O6tiJw=;
	b=NAejuk56K8M3txgeGxmjcjXbcbrMMftnK8PYXsEj6OPhQcfecmOAUU/j6is1iTCNqeiSe+
	hZ/G5JgKbn3AiRAg==
From: "tip-bot2 for Martin Kletzander" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/resctrl: Avoid overflow in MB settings in bw_validate()
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Martin Kletzander <nert.pinx@gmail.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172839842767.1442.16988281796076435728.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2b5648416e47933939dc310c4ea1e29404f35630
Gitweb:        https://git.kernel.org/tip/2b5648416e47933939dc310c4ea1e29404f35630
Author:        Martin Kletzander <nert.pinx@gmail.com>
AuthorDate:    Tue, 01 Oct 2024 13:43:56 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 08 Oct 2024 16:17:38 +02:00

x86/resctrl: Avoid overflow in MB settings in bw_validate()

The resctrl schemata file supports specifying memory bandwidth associated with
the Memory Bandwidth Allocation (MBA) feature via a percentage (this is the
default) or bandwidth in MiBps (when resctrl is mounted with the "mba_MBps"
option).

The allowed range for the bandwidth percentage is from
/sys/fs/resctrl/info/MB/min_bandwidth to 100, using a granularity of
/sys/fs/resctrl/info/MB/bandwidth_gran. The supported range for the MiBps
bandwidth is 0 to U32_MAX.

There are two issues with parsing of MiBps memory bandwidth:

* The user provided MiBps is mistakenly rounded up to the granularity
  that is unique to percentage input.

* The user provided MiBps is parsed using unsigned long (thus accepting
  values up to ULONG_MAX), and then assigned to u32 that could result in
  overflow.

Do not round up the MiBps value and parse user provided bandwidth as the u32
it is intended to be. Use the appropriate kstrtou32() that can detect out of
range values.

Fixes: 8205a078ba78 ("x86/intel_rdt/mba_sc: Add schemata support")
Fixes: 6ce1560d35f6 ("x86/resctrl: Switch over to the resctrl mbps_val list")
Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 23 +++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 50fa1fe..200d89a 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -29,10 +29,10 @@
  * hardware. The allocated bandwidth percentage is rounded to the next
  * control step available on the hardware.
  */
-static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
+static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
 {
-	unsigned long bw;
 	int ret;
+	u32 bw;
 
 	/*
 	 * Only linear delay values is supported for current Intel SKUs.
@@ -42,16 +42,21 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 		return false;
 	}
 
-	ret = kstrtoul(buf, 10, &bw);
+	ret = kstrtou32(buf, 10, &bw);
 	if (ret) {
-		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
+		rdt_last_cmd_printf("Invalid MB value %s\n", buf);
 		return false;
 	}
 
-	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
-	    !is_mba_sc(r)) {
-		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
-				    r->membw.min_bw, r->default_ctrl);
+	/* Nothing else to do if software controller is enabled. */
+	if (is_mba_sc(r)) {
+		*data = bw;
+		return true;
+	}
+
+	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
+		rdt_last_cmd_printf("MB value %u out of range [%d,%d]\n",
+				    bw, r->membw.min_bw, r->default_ctrl);
 		return false;
 	}
 
@@ -65,7 +70,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	struct resctrl_staged_config *cfg;
 	u32 closid = data->rdtgrp->closid;
 	struct rdt_resource *r = s->res;
-	unsigned long bw_val;
+	u32 bw_val;
 
 	cfg = &d->staged_config[s->conf_type];
 	if (cfg->have_new_ctrl) {

