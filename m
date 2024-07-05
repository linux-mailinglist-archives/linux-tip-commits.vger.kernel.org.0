Return-Path: <linux-tip-commits+bounces-1617-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4403928E91
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 23:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5DE287D8F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 21:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1736B17A934;
	Fri,  5 Jul 2024 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3CVxfEos";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ruu8T38O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCA7176FD8;
	Fri,  5 Jul 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213611; cv=none; b=ZCL6ROCXFto19lEDqkVfjGYQ6rRzf1UEtVFPuVRXDEYRHy9lq4A4rllwCyCcPrtTnpyFo97fA+h6LEHSxDWkRvwdoKKxk9mIEGuJezHVXmwqskNy6gvua+5j0QBGKyioUq7tByhPoHV9ILVlIFm0R8V85ohPPwBDJJDUFEo9zYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213611; c=relaxed/simple;
	bh=j6+YGmCt5TIswre4xWer9dkLHLPF8re7t2nB/EeMqgk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UNLDv7tt3AbOucwaa9MksNb5BN0Y6k86mcHGSxfrW4yl6Cmy3+vfkp+stdwVDZkXR6enzIumrdXlEpuc5QchdZ7jtm6HzdD6DiZRpM6vBecXphmPtYVGHRjxp2Z0nhlkeXnuZ1hTVhoy/GtG9jVQxgAXbZ63ZIUa/DTxmogmvuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3CVxfEos; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ruu8T38O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Jul 2024 21:06:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720213607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmVBk3llffhzvyn9fVY0GT+uRWj8wTUYMdG41kuQapM=;
	b=3CVxfEoshX8/3pbmxCIMda7Lyz/8i1+eLS/Ih51SaukPjNTk0b3diimkB1285f8ci/vevC
	YjDoPwsPl5X6aBuAJCPvr3LGUR5w5r+8MexQYcleT33zCwBz0HWF4fn0wS8vVX/ACB1zkc
	XLLgNMP/itPZKCOBJaeV5/dyU+oanF44qhiKfOPj+O/5XR0K9ZTCxACOZ1Fxm9wUosDGHA
	s3lsKWHxZC324Fso8XiyaKQx6ms3ueMMYfi1vVQXpK3AyRJ0By4k4yUeZWpXw2OwOsiYm5
	d+2jjUGUShccvJ2TKC/pRizkZhsIbegOAIlNTmk+1WoDCYkbs2Mtav+dkU+/RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmVBk3llffhzvyn9fVY0GT+uRWj8wTUYMdG41kuQapM=;
	b=ruu8T38O1IgkxkYFDKQRPqqwOv2XV763S5T5zvIRpGXYxaqj9AAkyhdQRmFIfnnIrKWOBF
	j7tgKkIQrybn0PDg==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel/pt: Fix a topa_entry base address calculation
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240624201101.60186-3-adrian.hunter@intel.com>
References: <20240624201101.60186-3-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360691.2215.16485051876594607373.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ad97196379d0b8cb24ef3d5006978a6554e6467f
Gitweb:        https://git.kernel.org/tip/ad97196379d0b8cb24ef3d5006978a6554e6467f
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 24 Jun 2024 23:10:56 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:21 +02:00

perf/x86/intel/pt: Fix a topa_entry base address calculation

topa_entry->base is a bit-field. Bit-fields are not promoted to a 64-bit
type, even if the underlying type is 64-bit, and so, if necessary, must
be cast to a larger type when calculations are done.

Fix a topa_entry->base address calculation by adding a cast.

Without the cast, the address was limited to 36-bits i.e. 64GiB.

The address calculation is used on systems that do not support Multiple
Entry ToPA (only Broadwell), and affects physical addresses on or above
64GiB. Instead of writing to the correct address, the address comprising
the first 36 bits would be written to.

Intel PT snapshot and sampling modes are not affected.

Fixes: 52ca9ced3f70 ("perf/x86/intel/pt: Add Intel PT PMU driver")
Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240624201101.60186-3-adrian.hunter@intel.com
---
 arch/x86/events/intel/pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 14db6d9..047a2cd 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -878,7 +878,7 @@ static void pt_update_head(struct pt *pt)
  */
 static void *pt_buffer_region(struct pt_buffer *buf)
 {
-	return phys_to_virt(TOPA_ENTRY(buf->cur, buf->cur_idx)->base << TOPA_SHIFT);
+	return phys_to_virt((phys_addr_t)TOPA_ENTRY(buf->cur, buf->cur_idx)->base << TOPA_SHIFT);
 }
 
 /**

