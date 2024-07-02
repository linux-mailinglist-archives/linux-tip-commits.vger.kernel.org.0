Return-Path: <linux-tip-commits+bounces-1574-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7B492482C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D077B25924
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 19:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7147B1CFD72;
	Tue,  2 Jul 2024 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bk2I7EO2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SFsf88Hf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CCA1CF3DB;
	Tue,  2 Jul 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948259; cv=none; b=NE5F+NAbkhZKcRul7sTsn0Ibkp4FBbeX0EmbKp+Ysjsb9JhOlEXf58UP8OFPd++H+w6ylWgXYKsDKjIyyRIcv2BpYVqz9ifoGhWF+tlxNG7UxozBGObuSVE2eA6DelZe1TmAsqiBweQ2e0XdGOz5QPpMu2mO8DIaZl4NcZ3Qku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948259; c=relaxed/simple;
	bh=e6k8mHxcAqKiUV8XrlehDfmh5kBt1dZoMMuyuAHS+7g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G5WBzO+cPwEQsE4TcO1sY4hNgAPGE6sTklcUXIisuvqbvGZ10fG3m/zQ1Q+5AeiuiJGvpUwtsJfSvRnS+0ufTRSYUibhPbH2aw8boOr4DXX27xx3baZnxYz9mfABZvu5SZg/+YRQ4GA4QT+DYiGBAyN8sF+wqpFQeL+oEQeA/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bk2I7EO2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SFsf88Hf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 19:24:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719948254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qFjzx8vQU1xYLbkLSPJnx/AbNTepOUkXKM8UIU4qUF8=;
	b=bk2I7EO2+otv+DhAeaaxYeedyqaLjBv2L268XE+kASpvg2g7HJIT2vRH7vEFrZ8BDRjm6V
	YGQLMfTNE2foUqLKVe5yB8J1WlEz2Ts9qzH8Tt0njnXo9EkQOQd6ybGIwMHAoEphfs0xjW
	3ToPBVfSUBycf2WftpLUiQHPu6ioq36tcXkN2rzqnejhnLnVy4RWynWzGVRV7norvpsVOV
	KvTwKqeU0Ao0DuPcpcddppwjWi4hIVaz7njdgZTucDLHhD9RFSlFZQv/pYyeKMI7lXJgXw
	QzyyVWlPj5IyItYPDCIbqO2wLzzEO783Z+o147pDcsDOmpR1I73fsPjWX8R9qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719948254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qFjzx8vQU1xYLbkLSPJnx/AbNTepOUkXKM8UIU4qUF8=;
	b=SFsf88HfwAc48a8gaYJh1KiUgeqbVVKiHBI1vVvpQ0gNW2DhdppzIN9GXHf14blSjloe/4
	2DvXJrcWKK6+mACA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add a new field to struct rmid_read for
 summation of domains
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Babu Moger <babu.moger@amd.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240628215619.76401-10-tony.luck@intel.com>
References: <20240628215619.76401-10-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171994825453.2215.4023928263267040624.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     fb1f51f677585f1b1ba17d2390963bbebe7a8cfa
Gitweb:        https://git.kernel.org/tip/fb1f51f677585f1b1ba17d2390963bbebe7a8cfa
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 28 Jun 2024 14:56:09 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Jul 2024 19:49:54 +02:00

x86/resctrl: Add a new field to struct rmid_read for summation of domains

When a user reads a monitor file rdtgroup_mondata_show() calls mon_event_read()
to package up all the required details into an rmid_read structure which is
passed across the smp_call*() infrastructure to code that will read data from
hardware and return the value (or error status) in the rmid_read structure.

Sub-NUMA Cluster (SNC) mode adds files with new semantics. These require the
smp_call-ed code to sum event data from all domains that share an L3 cache.

Add a pointer to the L3 "cacheinfo" structure to struct rmid_read for the data
collection routines to use to pick the domains to be summed.

  [ Reinette: the rmid_read structure has become complex enough so document each
    of its fields and provide the kerneldoc documentation for struct rmid_read. ]

Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20240628215619.76401-10-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/internal.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 135190e..681b5bd 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -144,12 +144,31 @@ union mon_data_bits {
 	} u;
 };
 
+/**
+ * struct rmid_read - Data passed across smp_call*() to read event count.
+ * @rgrp:  Resource group for which the counter is being read. If it is a parent
+ *	   resource group then its event count is summed with the count from all
+ *	   its child resource groups.
+ * @r:	   Resource describing the properties of the event being read.
+ * @d:	   Domain that the counter should be read from. If NULL then sum all
+ *	   domains in @r sharing L3 @ci.id
+ * @evtid: Which monitor event to read.
+ * @first: Initialize MBM counter when true.
+ * @ci:    Cacheinfo for L3. Only set when @d is NULL. Used when summing domains.
+ * @err:   Error encountered when reading counter.
+ * @val:   Returned value of event counter. If @rgrp is a parent resource group,
+ *	   @val includes the sum of event counts from its child resource groups.
+ *	   If @d is NULL, @val includes the sum of all domains in @r sharing @ci.id,
+ *	   (summed across child resource groups if @rgrp is a parent resource group).
+ * @arch_mon_ctx: Hardware monitor allocated for this read request (MPAM only).
+ */
 struct rmid_read {
 	struct rdtgroup		*rgrp;
 	struct rdt_resource	*r;
 	struct rdt_mon_domain	*d;
 	enum resctrl_event_id	evtid;
 	bool			first;
+	struct cacheinfo	*ci;
 	int			err;
 	u64			val;
 	void			*arch_mon_ctx;

