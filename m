Return-Path: <linux-tip-commits+bounces-1619-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD2A928E94
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 23:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09700288208
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 21:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713AA17B439;
	Fri,  5 Jul 2024 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lpd4dWuW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0lMJhmbo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9B176FCE;
	Fri,  5 Jul 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213611; cv=none; b=PNvN1uNt036F4ih9sMAC/8odTHjGFrIVMQc9KsOtDygdf4mcUc60MWB4N5Pp3gDGY/0YJ+aQ6ZONHJJachOytASuEHEGGnKMeY9OexepuwXest2hSoncsgWCmevEp0kicWCiL3gxZ+9MIpIWvSMUu3SwRFjULAdBKFZCzSui+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213611; c=relaxed/simple;
	bh=+ALrVRjXIJso1mjgruH+u1knxCalGDNznfir6NLd6/w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LPq+VSvXJ8oXbpopxR1pM357c6VI8eJzF4IUk7shtpu/DF6hb16HZAKHsUyF3dVrCTtCzM9/6szN9VohFa+/51WJec01up3Sz/DhTw/d23Hk/Euxsci8dw2Hnnea24QbzLXp+dJTD2oHAJ1prtGzqinNH7czQAzY+IQSE8mwV/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lpd4dWuW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0lMJhmbo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Jul 2024 21:06:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720213606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeaxAw4n5MSXCxf8ai41PNDlpltYYgtMxJMRifXHE3g=;
	b=lpd4dWuWwotwzHsH+8nCAhZ9P/ePzUT7Bdn3OpleTywzlO2XVskFpFvWKhKbMWJQMdAly4
	SX53gbR+0VW8rUzIQmOJDgWuqcTdgwcPpk59fo+xIiARswoPg1VED3xqrTAxNOXf+fIMNV
	YDAG8YQsUrDRedRZJCnHEn/bip88Rb4/uvodeOF9DqRAiRx+RYSTauxKeSH3dTh7JnbGzk
	SW6TEnrgoIPokaX9ljSxWYYyHeVXQoUYaR9vNigqosojDexDo3FfcOhdGWK7EBjb2q/tXp
	4ETOT7OX4uNYJBrdxVi+dupy7f1L9LiaCoHHoP1XWNo9DlAf9PCemtYWP9UIEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeaxAw4n5MSXCxf8ai41PNDlpltYYgtMxJMRifXHE3g=;
	b=0lMJhmboC63XFm3DJbqQZGNrStMgoxeUT+16CR/AMPAClHPZJYJGLDfAOZKxkzQVt9BORj
	LClmajAp+K9rykCg==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf: Fix perf_aux_size() for greater-than 32-bit size
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240624201101.60186-5-adrian.hunter@intel.com>
References: <20240624201101.60186-5-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360620.2215.8365367143880152080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3df94a5b1078dfe2b0c03f027d018800faf44c82
Gitweb:        https://git.kernel.org/tip/3df94a5b1078dfe2b0c03f027d018800faf44c82
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 24 Jun 2024 23:10:58 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:22 +02:00

perf: Fix perf_aux_size() for greater-than 32-bit size

perf_buffer->aux_nr_pages uses a 32-bit type, so a cast is needed to
calculate a 64-bit size.

Fixes: 45bfb2e50471 ("perf: Add AUX area to ring buffer for raw data streams")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240624201101.60186-5-adrian.hunter@intel.com
---
 kernel/events/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 5150d5f..386d21c 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -128,7 +128,7 @@ static inline unsigned long perf_data_size(struct perf_buffer *rb)
 
 static inline unsigned long perf_aux_size(struct perf_buffer *rb)
 {
-	return rb->aux_nr_pages << PAGE_SHIFT;
+	return (unsigned long)rb->aux_nr_pages << PAGE_SHIFT;
 }
 
 #define __DEFINE_OUTPUT_COPY_BODY(advance_buf, memcpy_func, ...)	\

