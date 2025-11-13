Return-Path: <linux-tip-commits+bounces-7332-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 151B7C5879A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 16:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03E18360093
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 15:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0AC352FA1;
	Thu, 13 Nov 2025 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CukVePZv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="53dkhuGv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB21352FB1;
	Thu, 13 Nov 2025 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047806; cv=none; b=CnvVZ1o+vocaRpIVDtlytqy3ozPWffdEmW7WuuAangLYzhnuDfam30wOb+n+meJseMBIJD8M6ar7ccjLMwMbSDCkkY0qB+4YVmk+O9J0YhBpi7GAl2z/9eRDVeJ/v2WzvVc3DRGMh2o4g4vf9RUuagDw9dbjzhG0ie2vUzryqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047806; c=relaxed/simple;
	bh=rN6q3FviL0YvzNBMs+YbX1D0vy6dVTbErUhvDsHxcoY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ryfasLwVxOlHViJms2IkSDX2ziivamZlVOMrzx1ARtLe9V3qESIa3/bFenUUXtJwU/cul8XVB+enfXz6QqYieaaj22GueF4nbriaz6YknnF8B4ZXO1w39+hMMn/aDQfMBQ+8L1xaDGC3GpjIanP3/4deum00vuoX6gGZqIKculY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CukVePZv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=53dkhuGv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Nov 2025 15:30:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgSOCqFWV8VKU9a7NEXCFWLLSHvTTPh1oxJqsOKL8iA=;
	b=CukVePZvnTzdOZjVOM5t9ngcZAOyrManen3g2GjhKC3NOW1GQbxKCFT/HXG8tq3H7nOze3
	wbKFHNmLYWH7hxg79qoa00Y9ws8Xjl9HDpjTYmivy9NJz1BUbDZArKhJBm/gXQL5C0Sn7g
	T1xf80CeV+oBoDolp/XqDZ3qdlAtJgonxYy8uuCsZ2ZR5QP6PDMqcXLJiA29F1X5bGaIKd
	7nBMSDGAN6YaWqinUszt45jB4RvBQRGVvdRZRNBsa4ediSSunwCF46EfnSh/OBJdrNfaZf
	Hpy3h3aOOgS/Hvyt5khTqHjkSuzPAsq5wipbPmhKGtsAVeB3iXWrA4Bq+pq4SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgSOCqFWV8VKU9a7NEXCFWLLSHvTTPh1oxJqsOKL8iA=;
	b=53dkhuGvQQErJju/6Rsr1Tmt/vkcWxDCtbd3QHeSp3jqtEwY5UABvFlRSyEkHpa38rNNF0
	q6RSak6Xho5egrCA==
From: "tip-bot2 for Andrew Donnellan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] entry: Fix ifndef around
 arch_xfer_to_guest_mode_handle_work() stub
Cc: Andrew Donnellan <ajd@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251105-entry-fix-ifndef-v1-1-d8d28045b627@linux.ibm.com>
References: <20251105-entry-fix-ifndef-v1-1-d8d28045b627@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176304780239.498.12299581343199238892.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     ebd4469e7af61019daaf904fdcba07a9ecd18440
Gitweb:        https://git.kernel.org/tip/ebd4469e7af61019daaf904fdcba07a9ecd=
18440
Author:        Andrew Donnellan <ajd@linux.ibm.com>
AuthorDate:    Wed, 05 Nov 2025 14:40:32 +11:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Nov 2025 16:27:56 +01:00

entry: Fix ifndef around arch_xfer_to_guest_mode_handle_work() stub

The stub implementation of arch_xfer_to_guest_mode_handle_work() is
guarded by an #ifndef that incorrectly checks for the name
arch_xfer_to_guest_mode_work instead. It seems the function was renamed
to add "_handle" as a late change to the original patch, and the #ifndef
wasn't updated to go with it.

Change the #ifndef to match the name of the function. No users right now,
so no need to update any architecture code.

Fixes: 935ace2fb5cc4 ("entry: Provide infrastructure for work before transiti=
oning to guest mode")
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251105-entry-fix-ifndef-v1-1-d8d28045b627@li=
nux.ibm.com
---
 include/linux/entry-virt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/entry-virt.h b/include/linux/entry-virt.h
index 42c89e3..bfa7677 100644
--- a/include/linux/entry-virt.h
+++ b/include/linux/entry-virt.h
@@ -32,7 +32,7 @@
  */
 static inline int arch_xfer_to_guest_mode_handle_work(unsigned long ti_work);
=20
-#ifndef arch_xfer_to_guest_mode_work
+#ifndef arch_xfer_to_guest_mode_handle_work
 static inline int arch_xfer_to_guest_mode_handle_work(unsigned long ti_work)
 {
 	return 0;

