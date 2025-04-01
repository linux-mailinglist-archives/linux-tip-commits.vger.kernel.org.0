Return-Path: <linux-tip-commits+bounces-4615-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C455A783A8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 22:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08574188F003
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 20:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D8D21420C;
	Tue,  1 Apr 2025 20:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ePWE32nP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tb8R+yEx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02CB1E9B39;
	Tue,  1 Apr 2025 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540807; cv=none; b=pyWkHb9IhBZu8ZhKN5/3H0CWE5jGPxxRIx3l4EG0dtOGqEExvNVvtHJiviwYKnNdQUEKxPe4vcIaq0sWBHq0Rk1KXiXOUiUFhpx9NL7tQbuii7KT3Tdc1irOPtJQWmPLC7nO7IIPvtJ9vmo5T66p5ubTK0nj/qTzz1MQCN/UiHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540807; c=relaxed/simple;
	bh=1Z4udBgOXtKjfcGcCFTypfodt+nENAV3p0TPlDYVdYY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mBL0WOp49fnivkxndCata14TDrqJPp17+Kob1yTuWRcknRlWMn6rhcweWkM9Sqh9WN5eeDEoOKvOHdTsD4MjjnQZI+bXt41f0dSibb6R2HLrQ1vHtFySU53TtQ4SdOVc+MI+xyKtb8HQhvGLtXYll98BDWWjbjN0mTaJdPaDyQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ePWE32nP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tb8R+yEx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 20:53:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743540803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auJu1kq6UZFTnIrj1dX3wByVthzOw70hNmqltyAejg0=;
	b=ePWE32nP47N5C1D77+ErUQV0RnBMNf+qxLAfjlW75Y1Ni05N9LOajwabrbmuREfdlOJ4X/
	ZIax0Xh2REWMfWzWXSW5PhHLIffx90hz8mgFhGNE6v8lg+fF4G/0zkTV3cXkOhFPDVaFtY
	nuxN5jsSTVMfpmuH9LaOrGcFJCZnSn19IXaW+ceFYpapEF4QYYI5QbqyLFNafUU0zrRFih
	ET8Z22ZdVrV7IHXjoHaXAVFormX553RoKTid0pNirhHYQpg4wX7AMf87b2+rcyoqRghKeM
	HdcmESZ2iVCSk4vVxWBKsfW27mhPiruKe443CdjKc8K1VooSWbuTFfCSfDj1Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743540803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auJu1kq6UZFTnIrj1dX3wByVthzOw70hNmqltyAejg0=;
	b=tb8R+yExgCHKKexKQwXilnbHvaQ9GckK7ciaqtneYbNIbE28hLwlzKIcAkDmCHR745z4jo
	O6oU/uAt1HQEmcDQ==
From: "tip-bot2 for Baoquan He" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Remove the arch-specific p4d_leaf() definition
Cc: Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250331081327.256412-7-bhe@redhat.com>
References: <20250331081327.256412-7-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174354080311.14745.10273367604522068517.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     06e6e99da66cfca1ebac52c09c3a025ef5ccf959
Gitweb:        https://git.kernel.org/tip/06e6e99da66cfca1ebac52c09c3a025ef5ccf959
Author:        Baoquan He <bhe@redhat.com>
AuthorDate:    Mon, 31 Mar 2025 16:13:26 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 22:47:02 +02:00

x86/mm: Remove the arch-specific p4d_leaf() definition

P4D huge pages are not supported yet, let's use the generic definition
in <linux/pgtable.h>.

[ mingo: Cleaned up the changelog. ]

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

