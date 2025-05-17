Return-Path: <linux-tip-commits+bounces-5638-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF1BABA946
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFE34C1B6E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF6F1EE03D;
	Sat, 17 May 2025 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EALZ9zTT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XWxUory6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9039D1E2834;
	Sat, 17 May 2025 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476174; cv=none; b=HAB0fNiv3qCfnTlw0++/zDXRNJeJsKOcjkrT4dbyMmHmOL0hln9mqzp1YpNmuHJAQ5kDLwpl/tTcnqx+9dO0HOHtjszh2Q7OHhnfGpESznS9owPtFTVXxsyq7ZmOlTx4J6SKvUoU+bqRThk7sq3cotL7StzFOKjL3qlEzUSIY+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476174; c=relaxed/simple;
	bh=HhWoDembTmSGrRAVKIoD0uMBqTP8eEmfd9+HgMtgMbQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oFqVAPH4ozIwP08qmiMtmPvj8Rv/E6n2XUCIC4QR2PWnm/WVOh2PaSK6QkRtvqeaa/5p2oGaPxtM6h4LzXaQ/zJR/IhAL3ekZAgPCBeJafS2DmAceudnKHgqznKuJAHQS9NSJNU8Kq+IB+IysVqSVS20mU7UTJ2TSl8dKsG+ut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EALZ9zTT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XWxUory6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:02:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lvLcTD+lcWzpyhaaeVJr2aC8IodsEKQwrfdsaxOuV0=;
	b=EALZ9zTTWOlCqm+s73mZHoshvD4CZNRRQpJazvoTfI8JRpAu/oqyws5h1fV5OO9pIEjF0+
	1i4srsZOOYnaDkFSheNU69690fHhjRK1M0eVyD9mGBoZqFFKcmXEh4lhpb+WxNCYMv6aqo
	BdsdmwuKAAkT+Ozf63hepaBPHhkb3LI6yovm9Y5t2ji4bFaVrOCK9rAxbw0K4WN1GslEtf
	RdiS6qbHYNXcsmv104e49m2NZAY3oMlnj8hzn+oi5zD0MijUK8CLdH6P02zxm5GxZwCAvo
	3o9BeOSLRsxYX1v5M7KYNHGYkNJNIx/iLoSfsCtcKtwGPWc/3hcfVi3FHxijLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lvLcTD+lcWzpyhaaeVJr2aC8IodsEKQwrfdsaxOuV0=;
	b=XWxUory6z2XcBZ+pU6msyt3hQJBQHlmMGe6Hs/uDD3zoA4VwJVFl1tAfSPbsuYeZ0kzprv
	n2YFukAvKAe/noBw==
From: "tip-bot2 for Dave Martin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Relax some asm #includes
Cc: Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Peter Newman <peternewman@google.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Babu Moger <babu.moger@amd.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-23-james.morse@arm.com>
References: <20250515165855.31452-23-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747616981.406.4962690696174848120.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     b7b57edbf5681c7d0ed504a3a4e912bb68661ab9
Gitweb:        https://git.kernel.org/tip/b7b57edbf5681c7d0ed504a3a4e912bb68661ab9
Author:        Dave Martin <Dave.Martin@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:52 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 May 2025 14:34:31 +02:00

x86/resctrl: Relax some asm #includes

checkpatch.pl identifies some direct #includes of asm headers that
can be satisfied by including the corresponding <linux/...> header
instead.

Fix them.

No intentional functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-23-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index db0b75b..bb39ffd 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -11,6 +11,8 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/cacheflush.h>
+#include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/debugfs.h>
@@ -22,7 +24,6 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
-#include <asm/cacheflush.h>
 #include <asm/cpu_device_id.h>
 #include <asm/perf_event.h>
 

