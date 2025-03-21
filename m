Return-Path: <linux-tip-commits+bounces-4417-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B50EBA6C279
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Mar 2025 19:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DAE3AECBD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Mar 2025 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830D6222582;
	Fri, 21 Mar 2025 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Ft4CERO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zKFY/i7+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F3C1ADC6D;
	Fri, 21 Mar 2025 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742582110; cv=none; b=ivnKJ7XmKbLfmPtXbMLp6tGXOW+KzLQjKGHdmT03mUAd4uSJHl8BGlAk9hAn1LODZIWl232binP5oihzUJQGv10hbVJO3cDFcPK6l8Lb44qNosraxvVqAEnfFaMpRjgbpHidwqmMrBs52C25WR+GVw3z46LvaekkCXVkKTWSRQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742582110; c=relaxed/simple;
	bh=zzq4DZuoDL4dfG1LaMU5dZMUYxpynJqXdyPSvDEp8CU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f1FHjp2J7mpR5BsiPraLK3mo5lH6AJdH2/Xo1X1Yh7TEi23D64A4R1jYrm/IKDIhf4/emCIHo9w8xuBPO5YYIppnzH8e8wdx55oQpyC7EpJ7QVovtZ9KfHeWLZ+wZSKZxbu9xDIR2e2tpJXYyxjV4kopsGSksv65BT1M4kH3CC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Ft4CERO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zKFY/i7+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Mar 2025 18:35:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742582106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtXy9UEiedxQFmfuZO3Rv+cQZcODL2rVt4DC4gX5reE=;
	b=2Ft4CERO083pirxDXVGBB9j6t1Jm6/XVxbn+c30dzQrB38gtY97HUGHZcdcmKhoPSIHF1z
	odQuU/y64hwgy7a/Fbl4hcsj05JEbNBTkR33pxTUtHcMwDvHG5XzvUs/ZJXGWLZaVm7hEY
	AN97gIBUTHiXNkras49HakEnKELs6tCCODIeUXsEUhkMlwrGpU8VfvZCelzbkwYc2aWc+I
	nEJTmKU2mGrj16oh7Swex4XWStUuxVatFGGwA0ggrimxlU851hSMlpQIRNjpuVvxsI+Une
	6Iw+2aWHQgPw90qbpdh8txRDpon2q4BSqZJQ98m/km/tKZCNTyPbqWd5gFLEiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742582106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtXy9UEiedxQFmfuZO3Rv+cQZcODL2rVt4DC4gX5reE=;
	b=zKFY/i7+gscu5OTa6ZDnR+dOG64+h6piCzy71yur7/F5GRyYDkbLot9jk30IPdSe+aW9bd
	0jejqeBBW2vEPxBw==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] selftests/timers: Improve skew_consistency by
 testing with other clockids
Cc: Lei Chen <lei.chen@smartx.com>, John Stultz <jstultz@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250320200306.1712599-2-jstultz@google.com>
References: <20250320200306.1712599-2-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174258210083.14745.7398376389141043766.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e40d3709c0225f5f681fd300f65a65ac63b10f83
Gitweb:        https://git.kernel.org/tip/e40d3709c0225f5f681fd300f65a65ac63b10f83
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Thu, 20 Mar 2025 13:03:01 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Mar 2025 19:16:18 +01:00

selftests/timers: Improve skew_consistency by testing with other clockids

Lei Chen reported a bug with CLOCK_MONOTONIC_COARSE having inconsistencies
when NTP is adjusting the clock frequency.

This has gone seemingly undetected for ~15 years, illustrating a clear gap
in our testing.

The skew_consistency test is intended to catch this sort of problem, but
was focused on only evaluating CLOCK_MONOTONIC, and thus missed the problem
on CLOCK_MONOTONIC_COARSE.

So adjust the test to run with all clockids for 60 seconds each instead of
10 minutes with just CLOCK_MONOTONIC.

Reported-by: Lei Chen <lei.chen@smartx.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250320200306.1712599-2-jstultz@google.com
Closes: https://lore.kernel.org/lkml/20250310030004.3705801-1-lei.chen@smartx.com/
---
 tools/testing/selftests/timers/skew_consistency.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
index 8345014..46c391d 100644
--- a/tools/testing/selftests/timers/skew_consistency.c
+++ b/tools/testing/selftests/timers/skew_consistency.c
@@ -47,7 +47,7 @@ int main(int argc, char **argv)
 
 	pid = fork();
 	if (!pid)
-		return system("./inconsistency-check -c 1 -t 600");
+		return system("./inconsistency-check -t 60");
 
 	ppm = 500;
 	ret = 0;

