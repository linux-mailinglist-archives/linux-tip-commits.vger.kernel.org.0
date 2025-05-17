Return-Path: <linux-tip-commits+bounces-5637-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BF7ABA945
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E567A59F2
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CA51EB5DA;
	Sat, 17 May 2025 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oM5Vrw+a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rDNN+jIL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201F11A0BD6;
	Sat, 17 May 2025 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476173; cv=none; b=afjzvojPgIOA2Ut4xWVJyXIsp6XUKBKwn8wZCDL1p7rqOLpNMmY6awXW9E+kgI7gZiCIcLp4u4LpeC8krzYp79shYi7TO39hXclVsCKA/k2MdRpl8SlOnLbucqC5Qk5SjztW6sTFApEEqaPHg7XBnydMOL1FNDTdzkM3GPeVNW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476173; c=relaxed/simple;
	bh=k21zaEWEAB+RezfLiT94qA4SxKriBHKEmtaWhvVdqmE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LgAlIjbu8IoAqH+A6jL/Lbou4fF8KlICppPNmOxWy/NAikG5AVU22ZRyeQiVGb2vgeZv8yLtAUTT9/v0UWAbn3NeofxhdBGbvQzdxaN2ekFsgkksQ3OH+SM9DHOZ/AZ7WR0eUbL4EWjY+7VKkeBtd7l0469Ewm3IY5gCA2tLPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oM5Vrw+a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rDNN+jIL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:02:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476169;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VzQqwA1KyFRrXFsTveQSI29Cw4flvjmqAXR6n1qRRUI=;
	b=oM5Vrw+aHPI6LczgOEpvSuAGKjlsTVYwWLPWv5UFHpD3U6AH6CYVhgb5moFUdYuM7zcuqL
	xE1pjbWEJZcOIIhGyIXkTmU4b2P0V4iC3igFOJtsX0lwWOF6VqSqbBma7WTiFYb3Jfb0L/
	wJT/b/rMNBPyMk5dzI4jXOqfqAMdzHjeuvRuV+SHuHsFl8hGbS+11oi8PdrCrskaRhCNjq
	0DvRvkJ3bhuT14QodxBRCevmUn+jRcg6jpXtkqa5EyzT3hDZN9I1IiHBnY0jmZW5gXsfm2
	g56xExDwywizud1SNM4czQ5X7hWuotxRJV0cHivc3iZn1/jRv1OAJ+hch1O0Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476169;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VzQqwA1KyFRrXFsTveQSI29Cw4flvjmqAXR6n1qRRUI=;
	b=rDNN+jILAJDSx+cw3hpai80iXlRS6QD4HUcJrI2GDOqZgd9JMqIltsMN03ZKbx9j0sCLVd
	8Cb9pHk7KuE41CDA==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Always initialise rid field in
 rdt_resources_all[]
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-24-james.morse@arm.com>
References: <20250515165855.31452-24-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747616894.406.9467545233814833608.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     f6b25be204b8661e4c32fa770a4c9e3a113ee325
Gitweb:        https://git.kernel.org/tip/f6b25be204b8661e4c32fa770a4c9e3a113ee325
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:53 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 May 2025 14:35:22 +02:00

x86/resctrl: Always initialise rid field in rdt_resources_all[]

x86 has an array, rdt_resources_all[], of all possible resources.
The for-each-resource walkers depend on the rid field of all
resources being initialised.

If the array ever grows due to another architecture adding a resource
type that is not defined on x86, the for-each-resources walkers will
loop forever.

Initialise all the rid values in resctrl_arch_late_init() before
any for-each-resource walker can be called.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-24-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 58d7c6a..224bed2 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -60,7 +60,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 	[RDT_RESOURCE_L3] =
 	{
 		.r_resctrl = {
-			.rid			= RDT_RESOURCE_L3,
 			.name			= "L3",
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.mon_scope		= RESCTRL_L3_CACHE,
@@ -74,7 +73,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 	[RDT_RESOURCE_L2] =
 	{
 		.r_resctrl = {
-			.rid			= RDT_RESOURCE_L2,
 			.name			= "L2",
 			.ctrl_scope		= RESCTRL_L2_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L2),
@@ -86,7 +84,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 	[RDT_RESOURCE_MBA] =
 	{
 		.r_resctrl = {
-			.rid			= RDT_RESOURCE_MBA,
 			.name			= "MB",
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_MBA),
@@ -96,7 +93,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 	[RDT_RESOURCE_SMBA] =
 	{
 		.r_resctrl = {
-			.rid			= RDT_RESOURCE_SMBA,
 			.name			= "SMBA",
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_SMBA),
@@ -996,7 +992,11 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
 static int __init resctrl_arch_late_init(void)
 {
 	struct rdt_resource *r;
-	int state, ret;
+	int state, ret, i;
+
+	/* for_each_rdt_resource() requires all rid to be initialised. */
+	for (i = 0; i < RDT_NUM_RESOURCES; i++)
+		rdt_resources_all[i].r_resctrl.rid = i;
 
 	/*
 	 * Initialize functions(or definitions) that are different

