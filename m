Return-Path: <linux-tip-commits+bounces-3325-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 082AEA25A22
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C783C166DCE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784AC20A5C1;
	Mon,  3 Feb 2025 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FOLjg7k5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ULDjcZWW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE392063C2;
	Mon,  3 Feb 2025 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738587011; cv=none; b=D71w6y9hoFMWRusuCO9SI9MwPZ5Nq5RmxRItSENVu2DhYaG9e0MWIv1uuL7L86WGmXwXJgexLdEvU56jPHMnjL/5clcSVSW4SAoxOiLLCO9oFoKpnS7rycF3S0CnsI7WmfVRmsHReMlPNPU1txyTid1dTrgDpK2DFryyO22y/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738587011; c=relaxed/simple;
	bh=7BljVldY/8WIKrZdVZ2glFGM8CT8XMXt2/zdSDrobW4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V8gdz5y2ZoaHxAjVJ0llO4md8+nXJ8LE7vdUxGKtNrqJUn5xDIHvHtEIgsfg0KZ+bPGCnPeEIPuxNs2W9zMyuhVKrKMaykbbUHuastcqOGP3iviUT27t4ughCQYPyvGHK5r3M3WhdYng4/KDyWphMx1MJPXd5az9Z5xVedRkrcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FOLjg7k5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ULDjcZWW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:50:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738587007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+4r9ZRX9znd+FKUNN8yaL9tgcOOJg4ZfbtpBxkmEDA=;
	b=FOLjg7k5tVBeIPsJhG9xFTtYnk07tQs7R7w/+TSKH5g7ZlckxvdWeX8pN17e2f8vLzVo1F
	b+MnstQ7O1dxCG5W9Sk43ivxM8iO5Fb+CcssXdWFiueWh7cWhi/IHFWiAsBB1CVPhyFQgD
	iJ8hqLZAwXtYcdH6jexkn8vFvddL3PfrjEPW0+VzWNvSeJV+FO+4smmJ6zlKw3zSK0ostx
	0WtB/F1TeNfM7RjmXE1k5yEIZyqrgCmI5U+ozI4o+bouxPFO0GnhrKx05JBaDToHvG6yh6
	RS2t5ClNeDcUHN/fmsal8Eo63EOugrw/6ynz2qdXznnqccoFlDRdS1lG5SCnQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738587007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+4r9ZRX9znd+FKUNN8yaL9tgcOOJg4ZfbtpBxkmEDA=;
	b=ULDjcZWWy7qXbNt/CAcpdN1RNfSHjdxSlDAJg7AVF3tufmi5ZqKzObD4nPbZo5UHdmUPF9
	qcOgqaufEpRYOdAA==
From: "tip-bot2 for Mike Rapoport (Microsoft)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: cpa-test: fix length for CPA_ARRAY test
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250126074733.1384926-2-rppt@kernel.org>
References: <20250126074733.1384926-2-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858700679.10177.6725513729928336032.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     33ea120582a638b2f2e380a50686c2b1d7cce795
Gitweb:        https://git.kernel.org/tip/33ea120582a638b2f2e380a50686c2b1d7cce795
Author:        Mike Rapoport (Microsoft) <rppt@kernel.org>
AuthorDate:    Sun, 26 Jan 2025 09:47:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:01 +01:00

x86/mm/pat: cpa-test: fix length for CPA_ARRAY test

The CPA_ARRAY test always uses len[1] as numpages argument to
change_page_attr_set() although the addresses array is different each
iteration of the test loop.

Replace len[1] with len[i] to have numpages matching the addresses array.

Fixes: ecc729f1f471 ("x86/mm/cpa: Add ARRAY and PAGES_ARRAY selftests")
Signed-off-by: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250126074733.1384926-2-rppt@kernel.org
---
 arch/x86/mm/pat/cpa-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/cpa-test.c b/arch/x86/mm/pat/cpa-test.c
index 3d2f7f0..ad3c1fe 100644
--- a/arch/x86/mm/pat/cpa-test.c
+++ b/arch/x86/mm/pat/cpa-test.c
@@ -183,7 +183,7 @@ static int pageattr_test(void)
 			break;
 
 		case 1:
-			err = change_page_attr_set(addrs, len[1], PAGE_CPA_TEST, 1);
+			err = change_page_attr_set(addrs, len[i], PAGE_CPA_TEST, 1);
 			break;
 
 		case 2:

