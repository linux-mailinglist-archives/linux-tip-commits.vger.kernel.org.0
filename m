Return-Path: <linux-tip-commits+bounces-1572-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73EA924829
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B811F220C7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 19:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60331CFD58;
	Tue,  2 Jul 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vveY4UiB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hhIuL01y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4321CF3CA;
	Tue,  2 Jul 2024 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948258; cv=none; b=gPkKNfFtdQaGQh3rx9RYY8KznwH5hnO0Ba2Ev0/gPv08xvPHku+UdaKkMzTOU0fyy5cwabfudde1pEuDSKx4ZCR8Usj/ODNYzUGK+9osKkvFXkpo1qm5zH95Dt34hHgc4VzOA//dHQpPVTRdETJNU2be2MbgFT/nfOfStjOzqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948258; c=relaxed/simple;
	bh=94805oqwme+51/lRA423YLXZ/gkIplMTVoKleAhYdeQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=imVGNSnVqiA1hdeUcuClDgmRgvwtFh1mA6vEqpdYIGB3Xpe8hwg+b6YaScjEUsOIn2NrhpOmCD+yrE6pboCHdmlUxLKcv4kDzOnFqhhrzPInrFFPvrjOSA4oYCB5H7PaKrV4B6SA9EKTTGcTputw4o70RZ3Hrg42+QXXT30cjnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vveY4UiB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hhIuL01y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 19:24:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719948253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghU0IIyxgFhAVBblZ8igN7OxEvQchvM+F3yokf6NgJI=;
	b=vveY4UiBpbr3g+onKwTgMARZnwsFnY7GZ3m7JHgxNP10tkEwBT3YGwDWSXwkuI1Iq5c/pM
	bHpshfpRjUAe7fJR5xZtBln/9KXKXgKy96000ZGf1sGF4I9iUTcuddozHYKWX+4VT3Espx
	STKvDcDUNI2Xxm2fEBKWhvgSoTfSbiyFfLtf5oMVwONZrLvMDjD8bkDqciBSa8DG+EhncX
	FUO0XCwdCFNhXGS2J0OL+0eI9J/MgDz/1AycCAery10R/5E+LpDw3nrVvVJEroMzmOXUYs
	JaMEy3FFCTZGZQL+hCrgG5AD9Gx7LLW5fn2A+KklLpBZFTc0sJZsFJ2IIdjeIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719948253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghU0IIyxgFhAVBblZ8igN7OxEvQchvM+F3yokf6NgJI=;
	b=hhIuL01yb+NV+XAGK1VMEVLa1GYWl8xZn+zuKdMsqq3nJawQGxAhffqvG8xN0C8s+Ud1h5
	3td9hXOzolU4BeCg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Allocate a new field in union mon_data_bits
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240628215619.76401-13-tony.luck@intel.com>
References: <20240628215619.76401-13-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171994825349.2215.1522418083591820504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     92b5d0b1189ea9e9f00ae493fc99102fe7f2442f
Gitweb:        https://git.kernel.org/tip/92b5d0b1189ea9e9f00ae493fc99102fe7f2442f
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 28 Jun 2024 14:56:12 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Jul 2024 19:49:54 +02:00

x86/resctrl: Allocate a new field in union mon_data_bits

When Sub-NUMA Cluster (SNC) mode is enabled, the legacy monitor reporting files
must report the sum of the data from all of the SNC nodes that share the L3
cache that is referenced by the monitor file.

Resctrl squeezes all the attributes of these files into 32 bits so they can be
stored in the "priv" field of struct kernfs_node.

Currently, only three monitor events are defined by enum resctrl_event_id so
reducing it from 8 bits to 7 bits still provides more than enough space to
represent all the known event types.

But note that this choice was arbitrary.  The "rid" field is also far wider
than needed for the current number of resource id types.  This structure is
purely internal to resctrl, no ABI issues with modifying it. Subsequent changes
may rearrange the allocation of bits between each of the fields as needed.

Give the bit to a new "sum" field that indicates that reading this file must
sum across SNC nodes. This bit also indicates that the domid field is the id of
an L3 cache (instead of a domain id) to find which domains must be summed.

Fix up other issues in the kerneldoc description for mon_data_bits.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20240628215619.76401-13-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/internal.h | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 681b5bd..13d8622 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -127,19 +127,25 @@ struct mon_evt {
 };
 
 /**
- * union mon_data_bits - Monitoring details for each event file
+ * union mon_data_bits - Monitoring details for each event file.
  * @priv:              Used to store monitoring event data in @u
- *                     as kernfs private data
- * @rid:               Resource id associated with the event file
- * @evtid:             Event id associated with the event file
- * @domid:             The domain to which the event file belongs
- * @u:                 Name of the bit fields struct
+ *                     as kernfs private data.
+ * @u.rid:             Resource id associated with the event file.
+ * @u.evtid:           Event id associated with the event file.
+ * @u.sum:             Set when event must be summed across multiple
+ *                     domains.
+ * @u.domid:           When @u.sum is zero this is the domain to which
+ *                     the event file belongs. When @sum is one this
+ *                     is the id of the L3 cache that all domains to be
+ *                     summed share.
+ * @u:                 Name of the bit fields struct.
  */
 union mon_data_bits {
 	void *priv;
 	struct {
 		unsigned int rid		: 10;
-		enum resctrl_event_id evtid	: 8;
+		enum resctrl_event_id evtid	: 7;
+		unsigned int sum		: 1;
 		unsigned int domid		: 14;
 	} u;
 };

