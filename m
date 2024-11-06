Return-Path: <linux-tip-commits+bounces-2755-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF099BE36E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EA31C20DAC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F811DD0CB;
	Wed,  6 Nov 2024 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j8V54h4/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b0iUhs8h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A61173;
	Wed,  6 Nov 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887414; cv=none; b=IxPXeWUeNiFef93WhMtOPuq5D0B4DnrPyd85zxNllFgQpnXyHOxSS2vhE7ypbIXDaM20r5TT6CSvpn+gejjhOa9aQCxyyPawW+URGM3xjkA5xV36J4UNaO9anv+Dq1LhDC0up1YGMuAPxRqbSDXONHoXiv8DreqIKaZJnJwja7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887414; c=relaxed/simple;
	bh=JHyf9+2zTSqXYnZidLwgsjg1gFC03EvB2S46na4dU/A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BWSC/YJABhp8WDNKO3L8GQEJ74UrUgMtvP7k/FldfdkSO0GzRxZ35GZ8pFWbVtfyBB01tA37f2JZThV2sSHi6a4XBEv2Ih/2IjZVUwRyrAh4b8NupkE0Ll+6ica3tbtpf8hdk26zPU5fQVoYTIo2U4Ja1G8txSKyMSctE9LVC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j8V54h4/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b0iUhs8h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:03:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730887410;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJ9PZNIg7tYPkzPPeLyue4W3XRMtt8sYGNM24FEQF5A=;
	b=j8V54h4/i7cIcmP+p4Z2jnlRo4ZrVeZ/YWoWgZ4XB8qBLYqpHQ2FBEluyXdFDOd5hjFCpi
	wyWInyquiaiZUqObfdn6ykY+m8HE6LtiS3k1hZY2bBUlR4j+bRutGR0JWdNZZAGJLKyIC+
	xvWpW9iT+00r3Q2bYMV4F3RMojfvJLvxtBZqWi+1NA+kGr95lRbSKO7mcyiPKMQt9PNGug
	9Qlvyhl2SZfxAurkDXQGmw7sET9XmQo2RxSk74toom0qJ49Uygq5cpet9mcOoZjlvO93BV
	PdAnkl/pZyXBEAf/b4A0cJYZIDoGAFKlnHpKuTI6KVJooDoyiqfngeYYSOqSCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730887410;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJ9PZNIg7tYPkzPPeLyue4W3XRMtt8sYGNM24FEQF5A=;
	b=b0iUhs8h0kz46m9oWylCF1KryJY+ACQT/oH+kRBvjP3Q9W6Ee8GaVwtIp0BXmf/n9ivCXP
	12Y1qqVX7KpKmtCg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Support Sub-NUMA cluster mode SNC6
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241031220213.17991-1-tony.luck@intel.com>
References: <20241031220213.17991-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173088740941.32228.14785978598357685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     9bce6e94c4b39b6baa649784d92f908aa9168a45
Gitweb:        https://git.kernel.org/tip/9bce6e94c4b39b6baa649784d92f908aa9168a45
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Thu, 31 Oct 2024 15:02:13 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 06 Nov 2024 10:49:04 +01:00

x86/resctrl: Support Sub-NUMA cluster mode SNC6

Support Sub-NUMA cluster mode with 6 nodes per L3 cache (SNC6) on some
Intel platforms.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20241031220213.17991-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 851b561..5fcb3d6 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1158,11 +1158,12 @@ static __init int snc_get_config(void)
 
 	ret = cpus_per_l3 / cpus_per_node;
 
-	/* sanity check: Only valid results are 1, 2, 3, 4 */
+	/* sanity check: Only valid results are 1, 2, 3, 4, 6 */
 	switch (ret) {
 	case 1:
 		break;
 	case 2 ... 4:
+	case 6:
 		pr_info("Sub-NUMA Cluster mode detected with %d nodes per L3 cache\n", ret);
 		rdt_resources_all[RDT_RESOURCE_L3].r_resctrl.mon_scope = RESCTRL_L3_NODE;
 		break;

