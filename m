Return-Path: <linux-tip-commits+bounces-5144-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4FCAA4A7B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 13:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A6A168013
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 11:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51516252912;
	Wed, 30 Apr 2025 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zfukEi9i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uDR6UL/0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C412B9A9;
	Wed, 30 Apr 2025 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014334; cv=none; b=dVdWiP5dxiFPQpk2+8iVWv3T0dm89l1FzGC8K5RtEUPWRpEk3cD4Byy2BIyszuvyy2GNjS1Ceb2os4MkBDimobhHlmAkRzrOW+6ZGCEIlAjkjYP1MabU1apO86sSPK6KYHzvFsmkyqrC2bS3TRXZBqN0Byti8TjCjbXdtQsjyzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014334; c=relaxed/simple;
	bh=DOmsj3WDZ8ayBaG4l4Q5mgFdaO41BHHQ1xRp7ivg/tY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YVeRiEwrL+FsqtZRJSmNBJZKFAsTxoKiEGjQqQpDkh6lIEEojC+w67jZMMMH9CmNEznlvRX5twGqi15WhDGIIMwX4Cp10rBdWK21j+HUaWlWdKlBNRVvqHJqOqQWWB6l1gJqpfEmlR2Dy9NHbKdiWPFaoM0ra0IgOEJLzbHfiDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zfukEi9i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uDR6UL/0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Apr 2025 11:58:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746014331;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFQ/PqLxx/CTdGrvFQWdno7Np6n0e6JlBs9wlAj2kU0=;
	b=zfukEi9i6qOQ303w+grfpYhNHmeJZjTCGsZMSluNUgHmwpuQa+GQi7Oq0pvUvA1YYiYSXr
	9wjNCOjRzS235E0zqdOlMs1lhY5GeewbQzQQiP5FXkO3di/sQMj/7hCZFGs1nYGAz6nAXv
	dXt3Ev6WfL8s2hsrmtJPD6jA/NOogNUI9dtwBpNFRTAPCtm1llpj4dB/ugAyiAbukIkwd6
	ZHFTx7l4rDn9x9csWZQvdRPGCkiH+96Z/jTksH9EzXXRAcNuzE/Iry3MmlQpirzFT9QhY4
	VfMV8a+WB8qI1I4W3QR8ZgCUhNnbt381Le7yPKPGUFPAVGqY2P2qPg+fFgs3tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746014331;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFQ/PqLxx/CTdGrvFQWdno7Np6n0e6JlBs9wlAj2kU0=;
	b=uDR6UL/0+1msSS7g00uKI0AP6YY7Jcmliy8u6enhyhwljtOsqaCsD6dpS7M4PYxwN7Tr6I
	bevUvJRYVB2hrFCA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Check the X86 leader for ACR group
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250424134718.311934-4-kan.liang@linux.intel.com>
References: <20250424134718.311934-4-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174601433029.22196.7457046331996087982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     efd448540e6243dbdaf0a7e1bcf49734e73f3c93
Gitweb:        https://git.kernel.org/tip/efd448540e6243dbdaf0a7e1bcf49734e73f3c93
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 24 Apr 2025 06:47:16 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Apr 2025 14:55:22 +02:00

perf/x86/intel: Check the X86 leader for ACR group

The auto counter reload group also requires a group flag in the leader.
The leader must be a X86 event.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250424134718.311934-4-kan.liang@linux.intel.com
---
 arch/x86/events/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 9c5cab8..e8bce89 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -129,7 +129,7 @@ static inline bool is_pebs_counter_event_group(struct perf_event *event)
 
 static inline bool is_acr_event_group(struct perf_event *event)
 {
-	return event->group_leader->hw.flags & PERF_X86_EVENT_ACR;
+	return check_leader_group(event->group_leader, PERF_X86_EVENT_ACR);
 }
 
 struct amd_nb {

