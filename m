Return-Path: <linux-tip-commits+bounces-5748-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DCDACE46E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Jun 2025 20:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88011897D6C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Jun 2025 18:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37DD1FC7F1;
	Wed,  4 Jun 2025 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pBTgW1y0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a7kZkcsD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED861F9A89;
	Wed,  4 Jun 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749062223; cv=none; b=MUGP163BXtn4e8ApPqDSb5Fqqrv256lnam4uI7XFHDF6nKy0rNEVCMoVCA5k17d+pLsmvILn+nUeFysoRg2aiPVZzYb9aFpewpW0Rd8wAK11ANiXJUMG6BQ/tcMf1TbflCyTsyqm3Ww3oefiCNUMyZbD12so/4WryZ7Q26Ho3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749062223; c=relaxed/simple;
	bh=prPLDvjco2lb3lynxL0yuGQ8j5sJ0TMMjukMXXTYtBI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T5Khxgfdup8IUwbfaU0xEFQttY6uKrDuklIdRcE4uczxQigNPH8zAlcKlkTkOYLgo/k9eL34OHyJ77Syg2zezsYPMPlakv/jEqPj70HEld6t4kp53nuiMhw1uz6tGXN3/JhuwzFobxZoLQuZmfxYsaIk5NC0gPsVftBg1tRwwcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pBTgW1y0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a7kZkcsD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Jun 2025 18:36:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749062219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IW8bHYqDV/yt9xoUe+0Zr9NpAGnHPSajQm8DSu7QLvU=;
	b=pBTgW1y0vcVxZRbsSoKkyZkZdCdgk11ZU2lVpGfhZoVvm+DfJtwFJ40Cm5R9PlZCV3gmc5
	w43FWEFs5oxqxAg7JmoL/QWOCTFQ6J2cu90iv3ijfGhPKiazV8OV05yGMUBBynM//7s/J/
	wHM4V9pkz3CdfTsYcL9fzdMVngGPLXui9rj2DMswxBV1c473iMi9KtlrGaUyl0r2kf4HaS
	QS+28Sg1LdVnUTKGe0M5stfJIH98OdeMZgMEdMKf8tcaxq6XEmPt6IUl7/fcYuJZnfedNE
	ZquE2Ysl6jav+nmiHTCkASeNIH2Ux80FD9+fZV+rsdonx40xbvq2o7ns4WovfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749062219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IW8bHYqDV/yt9xoUe+0Zr9NpAGnHPSajQm8DSu7QLvU=;
	b=a7kZkcsD8gbJzSt8w8rSqh8HfLS/NyUBTjKGu6w2hmcdEoahDRG8dYkPcaUgVlwrjSuKvM
	590XwB9pLeSO0gAg==
From: "tip-bot2 for Zeng Heng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] fs/resctrl: Restore the rdt_last_cmd_clear() calls
 after acquiring rdtgroup_mutex
Cc: Zeng Heng <zengheng4@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250603125828.1590067-1-zengheng4@huawei.com>
References: <20250603125828.1590067-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174906221776.406.2054232973321413607.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     dd2922dcfaa3296846265e113309e5f7f138839f
Gitweb:        https://git.kernel.org/tip/dd2922dcfaa3296846265e113309e5f7f138839f
Author:        Zeng Heng <zengheng4@huawei.com>
AuthorDate:    Tue, 03 Jun 2025 20:58:28 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 04 Jun 2025 20:32:55 +02:00

fs/resctrl: Restore the rdt_last_cmd_clear() calls after acquiring rdtgroup_mutex

A lockdep fix removed two rdt_last_cmd_clear() calls that were used to
clear the last_cmd_status buffer but called without holding the required
rdtgroup_mutex.

The impacted resctrl commands are writing to the cpus or cpus_list files
and creating a new monitor or control group. With stale data in the
last_cmd_status buffer the impacted resctrl commands report the stale error
on success, or append its own failure message to the stale error on
failure.

Consequently, restore the rdt_last_cmd_clear() calls after acquiring
rdtgroup_mutex.

Fixes: c8eafe149530 ("x86/resctrl: Fix potential lockdep warning")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/all/20250603125828.1590067-1-zengheng4@huawei.com
---
 fs/resctrl/rdtgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index cc37f58..1beb124 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -536,6 +536,8 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
 		goto unlock;
 	}
 
+	rdt_last_cmd_clear();
+
 	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
 	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 		ret = -EINVAL;
@@ -3472,6 +3474,8 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 		goto out_unlock;
 	}
 
+	rdt_last_cmd_clear();
+
 	/*
 	 * Check that the parent directory for a monitor group is a "mon_groups"
 	 * directory.

