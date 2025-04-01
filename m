Return-Path: <linux-tip-commits+bounces-4618-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB0AA783C1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 23:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12893ADD58
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 21:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B7C1E5B6D;
	Tue,  1 Apr 2025 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xDQII0LH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nvKZ53Jp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3C1C174A;
	Tue,  1 Apr 2025 21:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743541430; cv=none; b=QvWS8u2fC+lCcP106fuTjUuYMFKN+QKZwh8LVYnwZFJQttjJg+ZLWawotK51GVfVTN42OFe9edqs3ptKhH+6YEplo/lxW5Ntuv60M9aFpupGEW8Gj4aZdtL/xebFtO5S0rdjmCU0SUE/B3IZPJTGyPRLwlqzXXS1DcEh4h0a6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743541430; c=relaxed/simple;
	bh=JZzHXOo6Kq/0qVjb4R3s5f+ZZuyb/JbzzPrUBIREcWo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k1CffgidK21fZfppvxvw/53HgHYu8MkuriSw9tRW3bQzzyRzM8lMAgvJFRQOwCye3cpPzIW/dwJekKcJbfGx6/GSaLlt3sXZd+ycbuNGoB/xOX1csnDwskp/Yacte6Doabic3O2y75zJwQW8LTHqBYWeMg4dv9EiCSaFTvhDZ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xDQII0LH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nvKZ53Jp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 21:03:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743541427;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KdgNxkHl5V5muvXVdQx05JUTkbnTRzyGyBJhA5EjzC8=;
	b=xDQII0LH1W8U1h5421aTPYA9T79A6uePEySIMOWthMdNl96gIQMrQNUA602sP8M08yyij8
	zO2O6fdyLPNxPBYG6VOrJ1G9WuaoGNxjqeqXL1NBVJXrkJDHA2ur+zA/ZfpjT5TPPqvIMq
	SNg6nC484mwOJnRkplaa86w0lnzLkGRrrsaoH7eGqnyhZz0/mB3xOB+tzCIeqaEpGzzwov
	q4yPpsySEqOZCl+hYrW8LwOnlPEz6lt931hT/7bd5wn9/xjBWRvppw8nCzQPBMX+ooyRP/
	VHRqQaQR+e7qCmYlWwujcKSNfCSndk+ABFhGxdbO92EIN6XpiwT6wZuxXBRG/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743541427;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KdgNxkHl5V5muvXVdQx05JUTkbnTRzyGyBJhA5EjzC8=;
	b=nvKZ53JpesiehCSg87e0pSWBOLUCsHsi/8hPHAhBAkr5Hx9J3cFtWQHL9FL9UrqAWPEew/
	MnwPIvaOB9zSraCQ==
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
Message-ID: <174354142637.14745.6334396639863551404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     2b00d9031e42eabc8d32847d231ef48b8be0373d
Gitweb:        https://git.kernel.org/tip/2b00d9031e42eabc8d32847d231ef48b8be0373d
Author:        Baoquan He <bhe@redhat.com>
AuthorDate:    Mon, 31 Mar 2025 16:13:25 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 22:48:56 +02:00

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

