Return-Path: <linux-tip-commits+bounces-2189-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD98596F920
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 18:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECF4286565
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D901D31B4;
	Fri,  6 Sep 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uwSVxvvs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SboeTaQE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D12D045;
	Fri,  6 Sep 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639379; cv=none; b=Worg8fqmQbzCoAcagHxidMiFolstDg0w/XgCYiXEr+9W/Jt9MafpmQyKiJ9Ksyc4Svciow5aCdfzr2sUr9tuzfWgc6mw/nkcbLWqTfW0j4lGfS/IQEDeMtUqqr1UHSawG25MWfromhOLGkNo7IlOs3gSjEFSuHrvqesOqnx3hCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639379; c=relaxed/simple;
	bh=zhJu4KnXTFuDWYHRJEprSlmJn9TpYBUrueXIv5ji6HI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ilJd2aoUN7TO10OX3vyWSKtR8IRLFlz2fOJKAOU7PxSgJ9+4LNvxROsitNSVNdMK0cz8R/aRKDPi6v6c5DkJL5fZ7LCGm8tOJaySJ/+Wz3aWLGJUJQ51eIPnpymidmyUPtXywKehaq2cLN+oSuH5cYuvbMFuTC5WJpg4NMTEjhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uwSVxvvs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SboeTaQE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Sep 2024 16:16:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725639376;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=2OZneEZOoJMj/kl8wGZMK1e1YPHUzvOgAulPkObYF/4=;
	b=uwSVxvvsHBzRKSsinhetrSrnuBV9lm1gdH1AYsDM1kwyeviJDIkn/zAgjMDDuQVLLyvSfP
	psrVys+/UeTARzyJBhPpLPql8LbBvxqDWwpVMFRVwGL5/dvkcsny0NAg8c7UudrFmqyUE4
	XajhFDhkhB6/rBVooot1E/GsNMIfenLigR1XPOUF/p1sL8BEMd5KJvFaHZtpLOgp7y2lgE
	f6kwoI3V7K9PZnZi0gt2yqamN3uaIvj8pxrI6xxFepxjPegIGI42GyUMlMsnWlX+vm67Dq
	g3sYZte6/nlaX7J9imtqL4HZexSp6rn+gUmGSIdH5ygq906rJnMqdCpoLJGfTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725639376;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=2OZneEZOoJMj/kl8wGZMK1e1YPHUzvOgAulPkObYF/4=;
	b=SboeTaQEyH5znbW4lcvA0XmWtEGua3GO73FGCb7Zg4ayWN4p6zv35xI/SWKo+O80hYHnUd
	ier7f64GOBPFfLCw==
From: "tip-bot2 for Aaron Lu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sgx] x86/sgx: Log information when a node lacks an EPC section
Cc: Dave Hansen <dave.hansen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Kai Huang <kai.huang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172563937540.2215.6104676471077228765.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     c8ddc99eeba5f00b65efeae920eec3990bfc34ca
Gitweb:        https://git.kernel.org/tip/c8ddc99eeba5f00b65efeae920eec3990bfc34ca
Author:        Aaron Lu <aaron.lu@intel.com>
AuthorDate:    Thu, 05 Sep 2024 16:08:55 +08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 05 Sep 2024 15:20:47 -07:00

x86/sgx: Log information when a node lacks an EPC section

For optimized performance, firmware typically distributes EPC sections
evenly across different NUMA nodes. However, there are scenarios where
a node may have both CPUs and memory but no EPC section configured. For
example, in an 8-socket system with a Sub-Numa-Cluster=2 setup, there
are a total of 16 nodes. Given that the maximum number of supported EPC
sections is 8, it is simply not feasible to assign one EPC section to
each node. This configuration is not incorrect - SGX will still operate
correctly; it is just not optimized from a NUMA standpoint.

For this reason, log a message when a node with both CPUs and memory
lacks an EPC section. This will provide users with a hint as to why they
might be experiencing less-than-ideal performance when running SGX
enclaves.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/20240905080855.1699814-3-aaron.lu%40intel.com
---
 arch/x86/kernel/cpu/sgx/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 6aeeb43..f3f1461 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -848,6 +848,13 @@ static bool __init sgx_page_cache_init(void)
 		return false;
 	}
 
+	for_each_online_node(nid) {
+		if (!node_isset(nid, sgx_numa_mask) &&
+		    node_state(nid, N_MEMORY) && node_state(nid, N_CPU))
+			pr_info("node%d has both CPUs and memory but doesn't have an EPC section\n",
+				nid);
+	}
+
 	return true;
 }
 

