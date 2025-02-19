Return-Path: <linux-tip-commits+bounces-3525-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A250FA3BC59
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Feb 2025 12:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BBE3B7815
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Feb 2025 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347A01CAA6D;
	Wed, 19 Feb 2025 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SZjF2gev";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rvVsCTRB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1D91DE8AA;
	Wed, 19 Feb 2025 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962921; cv=none; b=RTuAfyJEXyyMux045UdMG2IdpPD/jOzvJ1t4pdHRVbDeXEJqie8QIeWeIgNnLduTjMruUuQZTa52RWxfGGXVbauzPIj3FORNZUQuYq3ykk6I1dkZXRzU1O8yqsoxmRXwRslnQ/wX6Jl8W5Pa7GRlROgYK3Kd1Co/udFMk0cVpwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962921; c=relaxed/simple;
	bh=5P+xspsgpq/j8nae3I8KGFxbFgd5WITr/xi2lU7d4Zc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Uz9FTA6vq5+zygSCcz91qbYOWK7jB/aekxeONtzVaAVh3AIGavP9qY/y+jvml3leQIYgzjxs5PcVYKjzh7nmhIs6CNORaA6JySqOeKBymJ4ajFQupaVAGAu+xvriPORQf89LIlF/tn1W1ykhJYsbNM/UX8+JxP8mat9JHdBAvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SZjF2gev; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rvVsCTRB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Feb 2025 11:01:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739962917;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZyvLTjKoVdG+MXmJXxqDrvBXC3SChHTB02YpcJow14=;
	b=SZjF2gevtBr8g0XITEyNzWrJSb1f5OHbItr6k2by3lQZLET2lxpAkFAHQ3R4Fd7T2YHDEF
	RxRl2rrYCj7tmdCl3rTNT/e7DZhY9zDNqCEqOFmrfa/ZABqTUqOb9M18AEyu03uay67S05
	skfEz9O7FZvf56oVmTNrYtIVV45wCCN7yDulzPnkcsi3AjoJ9zpFV9SFZ/gbZM0w7AJm2v
	ZMB2ZUjiqLheYZBP7k2IyH78bLCM7nImsemtAOU0+3sRB2uHRIKN7Bawi3A5Yk27qDFmW9
	hAKWzATeyqptzA6jhXKXK/23+SZGuz/zz781cEa+FcNfw0VojXAySrZqh60dMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739962917;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZyvLTjKoVdG+MXmJXxqDrvBXC3SChHTB02YpcJow14=;
	b=rvVsCTRBaUmhP229O1g4tCOyoXffGNb7+Re4lT9yPgNUdeTUMijAzu3DlmolF7a4jD5hOo
	e1zw8QstUCQL2lCw==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf amd ibs: Sync arch/x86/include/asm/amd-ibs.h
 header with the kernel
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250205060547.1337-4-ravi.bangoria@amd.com>
References: <20250205060547.1337-4-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173996290231.10177.11960731856088166114.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3201bfa368fee5e70927e45222ff0b235352c01c
Gitweb:        https://git.kernel.org/tip/3201bfa368fee5e70927e45222ff0b235352c01c
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 05 Feb 2025 06:05:43 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Feb 2025 15:20:05 +01:00

perf amd ibs: Sync arch/x86/include/asm/amd-ibs.h header with the kernel

Sync load latency related bit fields into the tool's header copy

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250205060547.1337-4-ravi.bangoria@amd.com
---
 tools/arch/x86/include/asm/amd-ibs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/amd-ibs.h b/tools/arch/x86/include/asm/amd-ibs.h
index 93807b4..cb1740b 100644
--- a/tools/arch/x86/include/asm/amd-ibs.h
+++ b/tools/arch/x86/include/asm/amd-ibs.h
@@ -64,7 +64,8 @@ union ibs_op_ctl {
 			opmaxcnt_ext:7,	/* 20-26: upper 7 bits of periodic op maximum count */
 			reserved0:5,	/* 27-31: reserved */
 			opcurcnt:27,	/* 32-58: periodic op counter current count */
-			reserved1:5;	/* 59-63: reserved */
+			ldlat_thrsh:4,	/* 59-62: Load Latency threshold */
+			ldlat_en:1;	/* 63: Load Latency enabled */
 	};
 };
 

