Return-Path: <linux-tip-commits+bounces-4592-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F945A7641F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 Mar 2025 12:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5FE5169107
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 Mar 2025 10:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CE41DF977;
	Mon, 31 Mar 2025 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tUzObpq8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ep05b4cJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5811B12F399;
	Mon, 31 Mar 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416764; cv=none; b=Zmd/7NQ3Zw2I5AHEpbNKfCv//rqIUvzLkK1JbOH3lXAvYNZxMAY8PNkZjmWKILsjD3ZVC9cbw8TSLOW1IIQr058q2F1uRA4UqmRTwETNRPxldh4Ynv6yYPkHDRsGlNyQTEAXdDS1G5Q1oV3I2AaxyoSTONtILHfCqdQfZVaHjco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416764; c=relaxed/simple;
	bh=4yD9jPLYgaXm8vmLTe2+wDd2wod870ynkjwI3jYgihc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GC34AxOyyRkJlhNxkmWxYyjnC9AnNSPp8g8tCUz07BkrOtraK5gikPAD1ZusjYi2JJhV0Frby1D10wH06tO/+qKhjhbTnBu1qkOLg28U4l6JAtaoIBcY13mRRux81/PSi4Pi6UTxAmYIAaEcdwczn8zXBiarJ5W72aoOWGc4yhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tUzObpq8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ep05b4cJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 31 Mar 2025 10:25:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743416761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jNTE/j9H5Q2+3y4vlARKsb/IkEO2sDB7gjtf1vvoFa4=;
	b=tUzObpq8qVzHH11XGVXZ3xfKxMgD8tOTM5ZJI7fpuDnoYcHyVBYNWkN1ZPqg4w9VKG+SrQ
	2CWfYVey0PUmhfiMfvfdTnSanIr+KHWPELXaYt0kgB2KKlFvHN0epf9BdQh+vyvU6OyzL2
	LVrz0EkIw+E9rNMIQwtAZUZImXfkxxJLLpED+QXJB+63v+qrABgId4yNFutVbdjCM/uYY9
	y0l3SpgZOaAhOn1Aa7EPf38FZuejO5wb8CdSGckybj2VDUUjonFoIQOXYQVFP4Mc4d/k86
	fws3243sOJtx9rTVBuFDfiERVPY5e0Q5QoFzpZVDNWHIFAgnYT8qvA/TGzHJaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743416761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jNTE/j9H5Q2+3y4vlARKsb/IkEO2sDB7gjtf1vvoFa4=;
	b=ep05b4cJTDdIxwqyxMiw52dZ8MPxUXPFj4XGT//pcZg2w7gGPVTMozJTGMo3kMDtD2rDIb
	+BB9+ErhqGn7dkDQ==
From: "tip-bot2 for Baoquan He" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/mm: Simplify the pgd_leaf() and p4d_leaf() checks a bit
Cc: Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250331081327.256412-6-bhe@redhat.com>
References: <20250331081327.256412-6-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174341675280.14745.10833304422189217673.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     e62c7a4bd1d1e99e1ddd947cb526f833992c5bd4
Gitweb:        https://git.kernel.org/tip/e62c7a4bd1d1e99e1ddd947cb526f833992c5bd4
Author:        Baoquan He <bhe@redhat.com>
AuthorDate:    Mon, 31 Mar 2025 16:13:25 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 31 Mar 2025 12:08:17 +02:00

x86/mm: Simplify the pgd_leaf() and p4d_leaf() checks a bit

The functions return bool, simplify the checks.

[ mingo: Split off from two other patches. ]

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250331081327.256412-6-bhe@redhat.com
---
 arch/x86/mm/pti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 5f0d579..1902998 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -185,7 +185,7 @@ static p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)
 
 		set_pgd(pgd, __pgd(_KERNPG_TABLE | __pa(new_p4d_page)));
 	}
-	BUILD_BUG_ON(pgd_leaf(*pgd) != 0);
+	BUILD_BUG_ON(pgd_leaf(*pgd));
 
 	return p4d_offset(pgd, address);
 }
@@ -206,7 +206,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
 	if (!p4d)
 		return NULL;
 
-	BUILD_BUG_ON(p4d_leaf(*p4d) != 0);
+	BUILD_BUG_ON(p4d_leaf(*p4d));
 	if (p4d_none(*p4d)) {
 		unsigned long new_pud_page = __get_free_page(gfp);
 		if (WARN_ON_ONCE(!new_pud_page))

