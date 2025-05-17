Return-Path: <linux-tip-commits+bounces-5649-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FCEABA95C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48AF316CA65
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D59205E16;
	Sat, 17 May 2025 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vex6brEk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GZ34mUK0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345BD202C30;
	Sat, 17 May 2025 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476184; cv=none; b=XM8/GymZPvQrINhjcpBwPo3yKqqx7Pv+zhdU90q6pCdjW2ZomjcNBl9HCZ1TRGjrxPX0dDWkIapfB/jdtrqa7KA7wkW/iFMETOHQSsPWLfzAZ6ay8FbBQfOWbbI2XeaEuCW4cdepc6CHx5LKb22FJpmpGpg+dt6QupH0uvyzIyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476184; c=relaxed/simple;
	bh=qENGUqqvUGhvDJX+6xLnKM7JVZMAmn0irRtpRAEikgE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CyWAj2gXJVMN/vx6r4p95smi/v5M/Ao88xIWmbOFzZj8B6T/he3Wa+t9UkiT3YCdaeOXVvWVnK3BnybmLBGur9Mjuzx3TZkq+CGvLMx5wrahAD0yGz9Jq84JNWPJkIL/PtoeKhftHPGruxMSoxocE9hGGXCf7TLTxdgdRuEeVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vex6brEk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GZ34mUK0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:02:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476180;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xi7Vm71B7Kb4/BF0jr8M5dpzrQgSoj8qLC9vYBiVGo=;
	b=Vex6brEkE//7YgEUhiSX+jBq4vyQoqUQ89/NCvfW91dMtUyn/Emid90xlZfRuyNo/ww09e
	acvQfSFExHkqHboxZPbEWN9XfPkXIC79V6xvBemlqfl3cI6ZgMzFhtHT5LN6Ipcw7KSwX2
	xzw3tykv0u4Arlx9s+ouvYqZIcmcs/hJdYyu+HgWFLE8AItuuSKBOpZn5SPiXVCl6aYS6V
	ExHNSoXcZRrcmnJTmuIJHpXuFXus9htvKBPGP0aEELQf4Ahg2DQGFjDZwbKyiEZ1GXgRzJ
	dPOj7hpr5toHS5oU2rsXDaAoMIYurGYqz7y7DQaI4X+q0BSUNNw41ctQYjpNZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476180;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xi7Vm71B7Kb4/BF0jr8M5dpzrQgSoj8qLC9vYBiVGo=;
	b=GZ34mUK0kxUdJrGAc1z7KLC3nLaO74pCkNz9vPZMMHb0osXrPNFRN3oLJzo3DY3EfX7ZBO
	q9gq7DsqSEHYTVAQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Add end-marker to the resctrl_event_id enum
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-12-james.morse@arm.com>
References: <20250515165855.31452-12-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747617933.406.14850506587240007791.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     d4fb6b8e4640adeff9673ae398525be7382d3197
Gitweb:        https://git.kernel.org/tip/d4fb6b8e4640adeff9673ae398525be7382d3197
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:41 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 May 2025 10:44:36 +02:00

x86/resctrl: Add end-marker to the resctrl_event_id enum

The resctrl_event_id enum gives names to the counter event numbers on x86.
These are used directly by resctrl.

To allow the MPAM driver to keep an array of these the size of the enum
needs to be known.

Add a 'num_events' enum entry which can be used to size an array.  This is
added to the enum to reduce conflicts with another series, which in turn
requires get_arch_mbm_state() to have a default case.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-12-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c |  9 ++++-----
 include/linux/resctrl_types.h         |  3 +++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 73e3fe4..4962ae4 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -260,12 +260,11 @@ static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_mon_domain *hw_do
 		return &hw_dom->arch_mbm_total[rmid];
 	case QOS_L3_MBM_LOCAL_EVENT_ID:
 		return &hw_dom->arch_mbm_local[rmid];
+	default:
+		/* Never expect to get here */
+		WARN_ON_ONCE(1);
+		return NULL;
 	}
-
-	/* Never expect to get here */
-	WARN_ON_ONCE(1);
-
-	return NULL;
 }
 
 void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index f26450b..69bf740 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -49,6 +49,9 @@ enum resctrl_event_id {
 	QOS_L3_OCCUP_EVENT_ID		= 0x01,
 	QOS_L3_MBM_TOTAL_EVENT_ID	= 0x02,
 	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
+
+	/* Must be the last */
+	QOS_NUM_EVENTS,
 };
 
 #endif /* __LINUX_RESCTRL_TYPES_H */

