Return-Path: <linux-tip-commits+bounces-5049-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DE1A92592
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 20:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0C48A4666
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 18:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D309257AD5;
	Thu, 17 Apr 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PiQOdX+D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RaiK5M8B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729B32566FF;
	Thu, 17 Apr 2025 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913010; cv=none; b=j+obMViEZv/8Xm2TUEfJnPR7/cK3igpTf2FvnSY9rC+sx+wNRQGRH2Urrq1gdVD1kTU2GRyuyaEkfkhMxJd60KGQHsx0/OrQP2NSmFNqBrqBETrUnziDIzvO2HFlSn5WvknlShrR/+I3t1O2JYZNdNxX1iXOZFjijQ0hGhjEoAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913010; c=relaxed/simple;
	bh=k9KQF39sL8U9DnczBqy42a8lQJ196/z1UHtJXCTe2Zg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Nd7J0toHstaqzkT4VF4t1kv1fr5EO3V2aa5FwoZVaARsJo17c9GoWVTE2MUsym+eFzk+GYULxmB0tLezuefbj02Unn+js2yEJCOxr26wlt2pD0AydZ7RJUfdwH4p2hXefgrQNgj3YTGuWv4t2iyLnXbL7PTBnOiFo/yeyM+eDOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PiQOdX+D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RaiK5M8B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 18:03:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744913006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=sJbQuqoWP+GsAY3WuVYjsUpzEgTzSBa5tJXKUhExR5c=;
	b=PiQOdX+DMM+7cfj3njvqo7GQubjtz2C/UEK/5z8ZcvUzrQ9W00laFvOTyVEJYCVWj/snO8
	/0saBjeWTMbx5bT20aWaKJlkaJPvZSmK4L47qEluQLfq0H7CD8F9ODCubKoHVH1y4g0hTN
	A8Sjqu9y0gkjJw4Je6zqcoKSLr87tR/9f0Bv4LHLBbyeqAkVvJ9A4uPiZFcQPECgH4wsE5
	ltUN1KVDI3C8sm29QiahyvtwHUy8lVeZ1LcfnnHXe45hDyUhaEoqQlVsvUS/A1Vsf30/Dl
	3y+stl5UauL8elXZ6GRl9Vmp0auuWmyemYvTNJFwMBVYVUueuomGjyvP1IaIrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744913006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=sJbQuqoWP+GsAY3WuVYjsUpzEgTzSBa5tJXKUhExR5c=;
	b=RaiK5M8BUDY99VdSnof0Gxv08iSelqHSOKPxmwJ2p3qIZ2dooWIcrLSkRJP+KYD7Ap34vZ
	QlFyj8MlfoPN31BA==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Fix up comments around PMD preallocation
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174491300601.31282.7910421211046512242.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     82f120010f3b86c2f9c1279452c1ecab7bc117d2
Gitweb:        https://git.kernel.org/tip/82f120010f3b86c2f9c1279452c1ecab7bc117d2
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Mon, 14 Apr 2025 10:32:40 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 17 Apr 2025 10:39:25 -07:00

x86/mm: Fix up comments around PMD preallocation

The "paravirt environment" is no longer in the tree. Axe that part of the
comment. Also add a blurb to remind readers that "USER_PMDS" refer to
the PTI user *copy* of the page tables, not the user *portion*.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250414173240.5B1AB322%40davehans-spike.ostc.intel.com
---
 arch/x86/mm/pgtable.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 027e1d3..ca07db5 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -121,16 +121,17 @@ static void pgd_dtor(pgd_t *pgd)
  * processor notices the update.  Since this is expensive, and
  * all 4 top-level entries are used almost immediately in a
  * new process's life, we just pre-populate them here.
- *
- * Also, if we're in a paravirt environment where the kernel pmd is
- * not shared between pagetables (!SHARED_KERNEL_PMDS), we allocate
- * and initialize the kernel pmds here.
  */
 #define PREALLOCATED_PMDS	(static_cpu_has(X86_FEATURE_PTI) ? \
 					PTRS_PER_PGD : KERNEL_PGD_BOUNDARY)
 #define MAX_PREALLOCATED_PMDS	PTRS_PER_PGD
 
 /*
+ * "USER_PMDS" are the PMDs for the user copy of the page tables when
+ * PTI is enabled. They do not exist when PTI is disabled.  Note that
+ * this is distinct from the user _portion_ of the kernel page tables
+ * which always exists.
+ *
  * We allocate separate PMDs for the kernel part of the user page-table
  * when PTI is enabled. We need them to map the per-process LDT into the
  * user-space page-table.

