Return-Path: <linux-tip-commits+bounces-4619-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D72A783C3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 23:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEF018891F3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 21:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EEE1EA7F4;
	Tue,  1 Apr 2025 21:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qug6wspX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ga9wTF1L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4011E47A3;
	Tue,  1 Apr 2025 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743541431; cv=none; b=CjM8uULUPoGcQ7L8M0/b9JD2FFlS/2lKNN5MO3HI4ABwhDFWvSH/Z/4+0iy0e781H685R5Csw0+184YDIECKYvZNTZyHvz/i3pdL7mAvDHo46x1v6BM8Ec7ujpt7ipyhBRKRJuyFzzmTavbLGF3VD3nxo6MLRHpVqUxrJz/t5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743541431; c=relaxed/simple;
	bh=9dWdtc4zXUg2PP+2Iow0OcXh1hUTtgpvb4c27FypMY4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ic7/7RVryLO34FE/vBwqPmFaOJEo9SYjTVr2RGXFvr1QuJQx9jV/Qz1W2cRNYtz2+zgjdtHzfCvVsy5AqVEKkji6mwBOJl/P3b7qZXKLdVqmQIgKON8j+Xn7o+f6SMwuabTX7GgiRKV4Q82jsOBuBQ3tig4ezqGIzzUtO+6WwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qug6wspX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ga9wTF1L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 21:03:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743541427;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RnSvnUEqj/lY7Ix4/vg70IOY9aPOGIeQ4ZETy8Zrek=;
	b=qug6wspXLbG41ofdJFVNM+nxSYmyN0O3cnaWUBi5ghqTZDSo9q9QHTerRfYpnVtzZra1Wz
	1Q8rEfCUmQ5odsw/10E/Fiecqqyi1Tz7P6l9yyKSkqhRlcorDjUWhOC5eTqTTuZk+ruoPC
	L9bAv0gTwz9UaNpM+RrVDHGV+OqGLLfP/W4511V4AojMNmzgCU4abGLW3H8UNCZWGkTxYb
	gr7tgf9JD1fVHtTTUzyt6cNvVNo+0Sy7pZ2Bz02o9nbRAOVYeyzcrhasRIcLjqqLV+4y6Z
	2/6DFYJXoDeWIX4eaPKk0kx+SFTM+HYxnB66u/kyVU+ypbf3b0rBiY1trtBPRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743541427;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RnSvnUEqj/lY7Ix4/vg70IOY9aPOGIeQ4ZETy8Zrek=;
	b=Ga9wTF1LNdb0zn8EfEij2bHkbMq9vG8fkSMIXcbxKIZGY2p0dL6+QX9DCwMgTQkhTHzRCM
	+cWgZnyeESjhh5BQ==
From: "tip-bot2 for Baoquan He" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Remove the arch-specific p4d_leaf() definition
Cc: Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Oscar Salvador <osalvador@suse.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250331081327.256412-7-bhe@redhat.com>
References: <20250331081327.256412-7-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174354142718.14745.14768504678768643905.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     c083eff324edd73eb23f4bd3f40f388a3e7c2cd2
Gitweb:        https://git.kernel.org/tip/c083eff324edd73eb23f4bd3f40f388a3e7c2cd2
Author:        Baoquan He <bhe@redhat.com>
AuthorDate:    Mon, 31 Mar 2025 16:13:26 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 22:48:51 +02:00

x86/mm: Remove the arch-specific p4d_leaf() definition

P4D huge pages are not supported yet, let's use the generic definition
in <linux/pgtable.h>.

[ mingo: Cleaned up the changelog. ]

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Link: https://lore.kernel.org/r/20250331081327.256412-7-bhe@redhat.com
---
 arch/x86/include/asm/pgtable.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5f4fcc0..5ddba36 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -292,13 +292,6 @@ static inline unsigned long pgd_pfn(pgd_t pgd)
 	return (pgd_val(pgd) & PTE_PFN_MASK) >> PAGE_SHIFT;
 }
 
-#define p4d_leaf p4d_leaf
-static inline bool p4d_leaf(p4d_t p4d)
-{
-	/* No 512 GiB pages yet */
-	return 0;
-}
-
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 
 #define pmd_leaf pmd_leaf

