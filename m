Return-Path: <linux-tip-commits+bounces-2456-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4AC99FB82
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA08D1F2248F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740D81D63F2;
	Tue, 15 Oct 2024 22:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ted0IQWB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AzikERlE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870E81D63C3;
	Tue, 15 Oct 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032086; cv=none; b=f1hrRaZOKqzy5IXgOnVljIltGWmWdTRVvcdC4X/kji7H0hF8QcAriypAi/d7XxagVfdK/r8+KUV5ZF4MR5Lc3BEFBLdbchaO/Fow3PCEEI6OYAGTFxWJp7eKQfq7CNEvDXHjVWHXN5vXT9My8a0bXhEJ9zKzNNICSN8qy8+i5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032086; c=relaxed/simple;
	bh=4cpJvZNIZFhmr5E8jD7naO0+CQPtQSeBXQDSjvU/c54=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kWr4Ftt+TZlJgR3xTpKg4OvZ4LZO560K6z/OPmcqE0g2CKGbiuWLfOiZmkLPnelMcOCVtQDzh/kzuj4kph+fORb8UT9Gw++PRgdSlAOYzBvFzAiJNjyjPJV40y24wf6fFTrptscUmgB9NLiqIiY3FNRNpj1x97v3MBg0kKsOhEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ted0IQWB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AzikERlE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:41:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729032082;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=845oTHCw4wKJD4EJyWybmB+m96WW2m4mzPy0C4uzynI=;
	b=ted0IQWBiX7e2VF/OfJ5kXLQJVTMyqXLCSKNtypHHoDcxYsw02cukZDGPTQpF627FISlUA
	JHqN0l+DobP/iNESbZZqFRzbH4pYmNwD49S7fg6GzchQMT5NZIIcOb6bTWjpcdJPIbDE3q
	D+6WS/4KjgAHdfEsXBv9EEYfAtcoH6ww269ZMmtN593dyt1oSN4xr2kQvlnfZp4+Ywvase
	QBLHY56HOHX0otGwBMY8LpUmcAhaM1yTWSVtIJVmJI+gW3kkZ/Ac35Rcoiq7ec8UCifwK1
	v0JUXFEm4PEKpJUb8ZCSMFzHYzF2KiefH8T5sGuo99GfV34zU1gWMRXJXa2M6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729032082;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=845oTHCw4wKJD4EJyWybmB+m96WW2m4mzPy0C4uzynI=;
	b=AzikERlEYBRHw5Io78eK3NKgWp5DmNr0ZYNIc9rTiJtLD6I2Q8SvIlzXa5yrdhFM+ExDe7
	ALfrFVh24zXPhIAA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] checkpatch: Remove links to outdated documentation
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-10-dc8b907cb62f@linutronix.de>
References:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-10-dc8b907cb62f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903208173.1442.2866529064497564332.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6534086aa684248f779944a2ac9253d6d637eec6
Gitweb:        https://git.kernel.org/tip/6534086aa684248f779944a2ac9253d6d637eec6
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 14 Oct 2024 10:22:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 00:36:47 +02:00

checkpatch: Remove links to outdated documentation

checkpatch.pl checks for several things related to sleep and delay
functions. In all warnings the outdated documentation is referenced. Also
in checkpatch kernel documentation the outdated documentation is
referenced.

Replace the links to the outdated documentation with links to the function
description.

Note: Update of the outdated checkpatch checks is done in a second step.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241014-devel-anna-maria-b4-timers-flseep-v3-10-dc8b907cb62f@linutronix.de

---
 Documentation/dev-tools/checkpatch.rst |  2 --
 scripts/checkpatch.pl                  | 10 +++++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index a9fac97..abb3ff6 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -470,8 +470,6 @@ API usage
     usleep_range() should be preferred over udelay(). The proper way of
     using usleep_range() is mentioned in the kernel docs.
 
-    See: https://www.kernel.org/doc/html/latest/timers/timers-howto.html#delays-information-on-the-various-kernel-delay-sleep-mechanisms
-
 
 Comments
 --------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4427572..98790fe 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6597,11 +6597,11 @@ sub process {
 			# ignore udelay's < 10, however
 			if (! ($delay < 10) ) {
 				CHK("USLEEP_RANGE",
-				    "usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst\n" . $herecurr);
+				    "usleep_range is preferred over udelay; see function description of usleep_range() and udelay().\n" . $herecurr);
 			}
 			if ($delay > 2000) {
 				WARN("LONG_UDELAY",
-				     "long udelay - prefer mdelay; see arch/arm/include/asm/delay.h\n" . $herecurr);
+				     "long udelay - prefer mdelay; see function description of mdelay().\n" . $herecurr);
 			}
 		}
 
@@ -6609,7 +6609,7 @@ sub process {
 		if ($line =~ /\bmsleep\s*\((\d+)\);/) {
 			if ($1 < 20) {
 				WARN("MSLEEP",
-				     "msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.rst\n" . $herecurr);
+				     "msleep < 20ms can sleep for up to 20ms; see function description of msleep().\n" . $herecurr);
 			}
 		}
 
@@ -7077,11 +7077,11 @@ sub process {
 			my $max = $7;
 			if ($min eq $max) {
 				WARN("USLEEP_RANGE",
-				     "usleep_range should not use min == max args; see Documentation/timers/timers-howto.rst\n" . "$here\n$stat\n");
+				     "usleep_range should not use min == max args;  see function description of usleep_range().\n" . "$here\n$stat\n");
 			} elsif ($min =~ /^\d+$/ && $max =~ /^\d+$/ &&
 				 $min > $max) {
 				WARN("USLEEP_RANGE",
-				     "usleep_range args reversed, use min then max; see Documentation/timers/timers-howto.rst\n" . "$here\n$stat\n");
+				     "usleep_range args reversed, use min then max;  see function description of usleep_range().\n" . "$here\n$stat\n");
 			}
 		}
 

