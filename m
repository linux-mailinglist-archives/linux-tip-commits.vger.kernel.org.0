Return-Path: <linux-tip-commits+bounces-2190-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B044296F921
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 18:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBC1285FF2
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305681D363B;
	Fri,  6 Sep 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oEtEtmiU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NlaQ0uSa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611121D048E;
	Fri,  6 Sep 2024 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639379; cv=none; b=cn2uouhghTgTYAqKDME82q4YNp6zg/cXqjvxkIQEaC+03Gd8NrR4Y2b9YoQ/dPCFXg5aSt7z1CbS5DSPPF+455FJ3OiAbWkQzQqyNr0o06ftuMIUVBfXghQPXbg3OOxWTJymTX7wnBRMs9Imtic5tMQ4z3pCtT+Jf8R6jeZmtKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639379; c=relaxed/simple;
	bh=EG29gncKsMyuSh73OzxN7/9mYqc2X4KNWJUsYVBvwZk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ab5vU5OSvhv4SvSXddeRL0hEOwm2gKojfaKMWOgPosHljXgcol8bpqemfw08fKwX7vutzRscbdsYidE/7fXvl5/tAwzbOOujqrXe6UsXjWVAIaZP6T90Mbc2o5rgewRwBfbRGWHfcyvhPuFfBM8o2dpErmHr1W00w1Dt9WeReyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oEtEtmiU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NlaQ0uSa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Sep 2024 16:16:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725639376;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5ORhXgd6WLfAX376Y09WGzJJVAQXEoqIEorWMQQA59w=;
	b=oEtEtmiUNVa+W6wK30et73VzjXzOhIJpzlM3c0Fi3d7l8CUEMtp7Y0ntmhdHLtPL34sEu1
	5QwP7nHh7nHkowaVX+hJU3anHfN/uUZzZKHkpm5jcu9O3HZEqnmVfhyLX4hprOIKAPC/RZ
	yOxcCrNENDiO6gxcH1rVmCRWNGPW92AQ6cBb4HWdSrC6Fauk7r3lM/r0Qmgx6foWEsae+0
	VlUT0ZDb/x8ct1p3/dgOWLRO7RfwRkTiUj9kJF3wVI8jU/PJquVHOBRU1aJFf2Q6CICXGg
	Ku3Fb7BnyY4JoHmuHBhNVHGMb8WF0LxfFRqcyFgDw3F4YOG8o3tr1UpwVGLj/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725639376;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5ORhXgd6WLfAX376Y09WGzJJVAQXEoqIEorWMQQA59w=;
	b=NlaQ0uSaRkGd1798tPWK9cvvvg8U/ju4IbYgCargBQl58yTaPsDz60kYFLmcvTrAMirXhg
	srqLDVMhis0a8TCg==
From: "tip-bot2 for Aaron Lu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Fix deadlock in SGX NUMA node search
Cc: "Molina Sabido, Gerardo" <gerardo.molina.sabido@intel.com>,
 Aaron Lu <aaron.lu@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Zhimin Luo <zhimin.luo@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172563937606.2215.16977108983055159109.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     9c936844010466535bd46ea4ce4656ef17653644
Gitweb:        https://git.kernel.org/tip/9c936844010466535bd46ea4ce4656ef17653644
Author:        Aaron Lu <aaron.lu@intel.com>
AuthorDate:    Thu, 05 Sep 2024 16:08:54 +08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 05 Sep 2024 15:20:47 -07:00

x86/sgx: Fix deadlock in SGX NUMA node search

When the current node doesn't have an EPC section configured by firmware
and all other EPC sections are used up, CPU can get stuck inside the
while loop that looks for an available EPC page from remote nodes
indefinitely, leading to a soft lockup. Note how nid_of_current will
never be equal to nid in that while loop because nid_of_current is not
set in sgx_numa_mask.

Also worth mentioning is that it's perfectly fine for the firmware not
to setup an EPC section on a node. While setting up an EPC section on
each node can enhance performance, it is not a requirement for
functionality.

Rework the loop to start and end on *a* node that has SGX memory. This
avoids the deadlock looking for the current SGX-lacking node to show up
in the loop when it never will.

Fixes: 901ddbb9ecf5 ("x86/sgx: Add a basic NUMA allocation scheme to sgx_alloc_epc_page()")
Reported-by: "Molina Sabido, Gerardo" <gerardo.molina.sabido@intel.com>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Zhimin Luo <zhimin.luo@intel.com>
Link: https://lore.kernel.org/all/20240905080855.1699814-2-aaron.lu%40intel.com
---
 arch/x86/kernel/cpu/sgx/main.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 27892e5..6aeeb43 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -475,24 +475,25 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
 {
 	struct sgx_epc_page *page;
 	int nid_of_current = numa_node_id();
-	int nid = nid_of_current;
+	int nid_start, nid;
 
-	if (node_isset(nid_of_current, sgx_numa_mask)) {
-		page = __sgx_alloc_epc_page_from_node(nid_of_current);
-		if (page)
-			return page;
-	}
-
-	/* Fall back to the non-local NUMA nodes: */
-	while (true) {
-		nid = next_node_in(nid, sgx_numa_mask);
-		if (nid == nid_of_current)
-			break;
+	/*
+	 * Try local node first. If it doesn't have an EPC section,
+	 * fall back to the non-local NUMA nodes.
+	 */
+	if (node_isset(nid_of_current, sgx_numa_mask))
+		nid_start = nid_of_current;
+	else
+		nid_start = next_node_in(nid_of_current, sgx_numa_mask);
 
+	nid = nid_start;
+	do {
 		page = __sgx_alloc_epc_page_from_node(nid);
 		if (page)
 			return page;
-	}
+
+		nid = next_node_in(nid, sgx_numa_mask);
+	} while (nid != nid_start);
 
 	return ERR_PTR(-ENOMEM);
 }

