Return-Path: <linux-tip-commits+bounces-4942-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6F3A87357
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 21:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552B93B5668
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D54520110B;
	Sun, 13 Apr 2025 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bENqiQ5p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NdfFsIVy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9681FECDD;
	Sun, 13 Apr 2025 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570590; cv=none; b=ByRW/UnbFxOIbMoUwfR+Ew88FkeCRsX7CLtjV5MC6/MnRTYVa/aA7K47yptnFEAl4pxetA4URO0e5vmzAr7A0JjpHs/Ean0QIUEwrXKvlb4BAZ2c9oito+lp1LsAwZ/8Wqp84UMrMo6ZSCUuaMmK0+cMBaZYSLnsWmtU/A59bqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570590; c=relaxed/simple;
	bh=RZa+sjtu95Qt9z03TRnK8VoRytyqv68UBifK3jjza+4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=uokEYAlVg+a+vr+g9wyo7m1APSqzQy+Yu6aNqgNWG7d/VPQihqeRE4zvwFw++jpveNvFy7GEJpDpCQMNpyS1/rxtv8EUCsQAmXBMQMIdh1qcDYBtDygJf/Z93F830Fsv3IVzra+6UDcF/yBdgf4736RVyt7R2txGw+7X4OfNjfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bENqiQ5p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NdfFsIVy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=edGWqQo07v03VQjcBS06v0Np0TEgpaE77/TOcG1i0Xk=;
	b=bENqiQ5pzDQxHanJkAz81GWvOgBqJmDad5Ij4vlC9cHaepxleGQ+AohCo83W6K37mn5bQc
	JesfuhxDTsHWlKag9N7Urw2yM/NgK+VbVAga3QY/j98e20iybyY0W6kdlzdm/yIMi4MBP4
	l9OAfVuS47uepoXYdrNT4rSixbJSYE3lW6SXv0bvGOIYIVxscIx3mQJLRDAyuoe7EQUjAO
	OSZwJ1b/bTBXAfZB4w00uyE3McoZ+9OLszldQdGmPkgEgCiqrAa61QJ2zGjUit4wgrPH4L
	zYywV0jpYCQqAqS8uFn6TJz8uQpVFRrReZXrlkVvMAGbjKH/DeLclNpJx/UdoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=edGWqQo07v03VQjcBS06v0Np0TEgpaE77/TOcG1i0Xk=;
	b=NdfFsIVyvn0KlTU0zqXT59TJs+kqPDKv5XNtpNFoqk+0eXtBUnj+JX4Nq7CVfRe+UpKiWI
	hgyoHs6nI5lC/JAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/msr] x86/msr: Use u64 in rdmsrl_amd_safe() and wrmsrl_amd_safe()
Cc: Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@intel.com>, Xin Li <xin@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174457058635.31282.16974264712321417338.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     73bd1e01e98e71715aa060d40b8273ff6434e8d7
Gitweb:        https://git.kernel.org/tip/73bd1e01e98e71715aa060d40b8273ff6434e8d7
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:28:50 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:58:02 +02:00

x86/msr: Use u64 in rdmsrl_amd_safe() and wrmsrl_amd_safe()

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/kernel/cpu/amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 79569f7..b2ab236 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -31,7 +31,7 @@
 
 u16 invlpgb_count_max __ro_after_init;
 
-static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
+static inline int rdmsrl_amd_safe(unsigned msr, u64 *p)
 {
 	u32 gprs[8] = { 0 };
 	int err;
@@ -49,7 +49,7 @@ static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
 	return err;
 }
 
-static inline int wrmsrl_amd_safe(unsigned msr, unsigned long long val)
+static inline int wrmsrl_amd_safe(unsigned msr, u64 val)
 {
 	u32 gprs[8] = { 0 };
 

