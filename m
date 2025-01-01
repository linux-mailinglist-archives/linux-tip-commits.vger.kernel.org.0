Return-Path: <linux-tip-commits+bounces-3159-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFAC9FF3E3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 12:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09653A245E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 11:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF061E2838;
	Wed,  1 Jan 2025 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ntUJrDEM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WEVfD56G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8284D1E22FC;
	Wed,  1 Jan 2025 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735731860; cv=none; b=j02ghGhdv69pZ30Iqjj3Ajz7YIv03zkbkFN25B7eBNHzYNGLyUo/kv26jUtl1jhpkbUODQmnwLUkk4Q7cgvGHLleyRNUzMTJoJsF8woMbrxmRQ1umrnS2D9LYE4l7wetrVcB3itH9MsGZTe22BCvirvAC2fLCYoj0c/C8JtpS0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735731860; c=relaxed/simple;
	bh=Qg8wkkeT4LJjlewWx3+bEBxHRhAXbPDzBWbv7FbYD3Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BMr8TO2YDg9xDVGztzCb5IN0KcLIg1oPVsGIzOHNYhST9I2ay1iZbr1/Sa5NWbAStBM2GnDPwVy1hUENNNWXa1945QBzrgSZR7SxqA5jWDKH1pPseKXhTDRc+7i/HpA9wF86oSZVK22d9pelQ8n6E9IMHR66oAtp5PVVBoBxBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ntUJrDEM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WEVfD56G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 01 Jan 2025 11:44:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735731850;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4jsJHRRaJSE9t/qV6phGUtG7WY0mZ2FyqtcN7FUDYU=;
	b=ntUJrDEMka3MBpl4dOQ2BxnoAq/N5Cg+VdO0pSbIigw4CQrlk32GrBTr+7JLX+tJcKJ8Tf
	/lBqzPu0WZvSCCs57lLUwCvKUYshvGs8upp9ySvHtfO9taEkL9ZfO+0uZN03o/FC6Mo42n
	H9nJPG8K8BYTobMgURo3oHPphYW99ADU5DVm7NcntYzMPY7MVeZgE6MNj899Ib3bj36an6
	Ksj4PL937UHWgJTMbWil2bqtFILK4fnvRTnFg5nQO9bbcmhguF4Mhjnl1fZC03AoJiLemD
	QLM7Z7sHvjWHv+18FC92NahmPtPTl+73j11OVQWF5eiYRYdz2ppqgpmuo7mqRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735731850;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4jsJHRRaJSE9t/qV6phGUtG7WY0mZ2FyqtcN7FUDYU=;
	b=WEVfD56G0viZWfBOHOMcISn/mPyrX4+e6d9jL4LJXCGyE5oJAw2be6p/6jsgWDmTrku6YZ
	mIYWNVEyLWxb35AQ==
From: "tip-bot2 for Qiuxu Zhuo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: ras/core] x86/mce/threshold: Remove the redundant this_cpu_dec_return()
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241212140103.66964-3-qiuxu.zhuo@intel.com>
References: <20241212140103.66964-3-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173573184945.399.8421100650202328095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     64a668fbea1b6ec06ddca66d09cc49352f063342
Gitweb:        https://git.kernel.org/tip/64a668fbea1b6ec06ddca66d09cc49352f063342
Author:        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
AuthorDate:    Thu, 12 Dec 2024 22:00:58 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 30 Dec 2024 19:45:03 +01:00

x86/mce/threshold: Remove the redundant this_cpu_dec_return()

The 'storm' variable points to this_cpu_ptr(&storm_desc). Access the
'stormy_bank_count' field through the 'storm' to avoid calling
this_cpu_*() on the same per-CPU variable twice.

This minor optimization reduces the text size by 16 bytes.

  $ size threshold.o.*
     text	   data	    bss	    dec	    hex	filename
     1395	   1664	      0	   3059	    bf3	threshold.o.old
     1379	   1664	      0	   3043	    be3	threshold.o.new

No functional changes intended.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/20241212140103.66964-3-qiuxu.zhuo@intel.com
---
 arch/x86/kernel/cpu/mce/threshold.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index 89e31e1..f4a0076 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -90,7 +90,7 @@ void cmci_storm_end(unsigned int bank)
 	storm->banks[bank].in_storm_mode = false;
 
 	/* If no banks left in storm mode, stop polling. */
-	if (!this_cpu_dec_return(storm_desc.stormy_bank_count))
+	if (!--storm->stormy_bank_count)
 		mce_timer_kick(false);
 }
 

