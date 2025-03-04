Return-Path: <linux-tip-commits+bounces-3967-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1107A4ED6B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AB91880708
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DD4261382;
	Tue,  4 Mar 2025 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RfE76gKx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ySlYWoWE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD5B25F78A;
	Tue,  4 Mar 2025 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116840; cv=none; b=OF5pRP2O71dU36bfmPXAnwL2aGgAQSlnaLCSGiSK+7iN/KiXFT5x9wCLel5pjqytbBKu9iCIuff6Pr26fDv2zg61sPWmFW3O3CcVfCKz6PHu6jy8t565FI0FxuPR+XfFbbkKIsouVFhFNfervwjUsWNODWl+HU6ZLyZSd1Yqbz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116840; c=relaxed/simple;
	bh=3jFbfyarmHomwd4GrtbINydKceq2WeBrj//jYuiDlzs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r+BGAfD9BpuiKyHIa6W7VxeDyP4Lncuvio2CWrMAyC4XiqxEGPx+W8f4W23U/CebpwC8quhNqgYBtyw4WvokcnH4bO7VRcNAg6Y52O/CKxdorXX0k85AV9Frxh8oqueC9jsFCVT19XRpBiCCXipuF+aqxIz3+hPJbfrzYS9WJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RfE76gKx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ySlYWoWE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:33:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741116837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cs0CJOe/vZ2WZbn3vOoAzjY++nf7Zw93Yguld74+6g0=;
	b=RfE76gKxPirQYt871S/plO8Wx0SJSJfcOXdWVCXeFSUBn1vFi70dceg9NDAGZ4vcy5/C67
	sBjJy2ZDMqxVIQafSviTbsQqR+9eoms28S9gdHiJ9wJomVp4SfH0GtcLSV+cj8susxpudX
	RssJFWYR2IxBf2am5L4AsKpRCuGI7lpkKO+XOfA+UliYGzwQ/TLqN1EIe6FyReXNy+I24l
	svBmM1gcS+RQSffQm6weiOK/D/zJzpMswSK+cLJOjkCE1E9Z7v2BAGf17uN9dd5LB+vZu3
	K/uEFtKkS4ZiqW3ec+6Y76KkgOKKroAsgO5sKs2q8f8eROTvbcYsQu0IYYt/7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741116837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cs0CJOe/vZ2WZbn3vOoAzjY++nf7Zw93Yguld74+6g0=;
	b=ySlYWoWEaKves3l8j0CGmnkiEK/A7ZKtoAncouBl6vjPLX0RgeMpVAJMBxsR5Aq+bAFeS/
	vRHOtXCN5uF3syCA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/percpu: Fix __per_cpu_hot_end marker
Cc: Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 Brian Gerst <brgerst@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250304173455.89361-1-ubizjak@gmail.com>
References: <20250304173455.89361-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174111683652.14745.17782690579153562758.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     d99d0dea2fabf3f7538dd3a19b43b9aea4468037
Gitweb:        https://git.kernel.org/tip/d99d0dea2fabf3f7538dd3a19b43b9aea4468037
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 04 Mar 2025 18:34:36 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:18:02 +01:00

x86/percpu: Fix __per_cpu_hot_end marker

Make __per_cpu_hot_end marker point to the end of the percpu cache
hot data, not to the end of the percpu cache hot section.

This fixes CONFIG_MPENTIUM4 case where X86_L1_CACHE_SHIFT
is set to 7 (128 bytes).

Also update assert message accordingly.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Link: https://lore.kernel.org/r/20250304173455.89361-1-ubizjak@gmail.com

Closes: https://lore.kernel.org/lkml/Z8a-NVJs-pm5W-mG@gmail.com/
---
 arch/x86/kernel/vmlinux.lds.S     | 2 +-
 include/asm-generic/vmlinux.lds.h | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 31f9102..ccdc45e 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -331,7 +331,7 @@ SECTIONS
 	}
 
 	PERCPU_SECTION(L1_CACHE_BYTES)
-	ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <= 64, "percpu cache hot section too large")
+	ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <= 64, "percpu cache hot data too large")
 
 	RUNTIME_CONST_VARIABLES
 	RUNTIME_CONST(ptr, USER_PTR_MAX)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c4e8fac..4925441 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1072,9 +1072,8 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	. = ALIGN(cacheline);						\
 	__per_cpu_hot_start = .;					\
 	*(SORT_BY_ALIGNMENT(.data..percpu..hot.*))			\
-	__per_cpu_hot_pad = .;						\
-	. = ALIGN(cacheline);						\
 	__per_cpu_hot_end = .;						\
+	. = ALIGN(cacheline);						\
 	*(.data..percpu..read_mostly)					\
 	. = ALIGN(cacheline);						\
 	*(.data..percpu)						\

