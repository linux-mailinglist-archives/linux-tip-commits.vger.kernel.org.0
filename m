Return-Path: <linux-tip-commits+bounces-1622-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C10B92A186
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 13:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB55B283631
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 11:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375627F470;
	Mon,  8 Jul 2024 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xpfouwIG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MXI7X8dU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20B7E57F;
	Mon,  8 Jul 2024 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439369; cv=none; b=hdqU57YdwOvfqn/jqGI8XjwN0OP+2oydxoo8beRrVRq3dp9cYICgDCxZYfo7ZWyNpkagd152KIQoIqdcDF5Sy0oWNYMSUmGSlqY12s/opDFa8Vw5zXXCFICS5YhoMWu7SMuMMz+3AzYNfu+ImSPGQX2VFRp1IQuLcIIeO4tGaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439369; c=relaxed/simple;
	bh=yxYuWUOiEzMPIr9eIOnEB2yA+hic/+m5MEj2MEoVLV8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=mF9cX8Kzqn7aQqq7PXBOFpxRR7hwc9PQoCscWuWtlBJQqjulwhRFA4mHJay60LVJIsR3GnmdffI9pYKvV3Tf92+NyaqAc+1U0ZqGt6t2lmqXcwQTNlZ6+KOgZ72hXhhKoGrNgkU7xZ8XPd1pBUeD6RlMiCw3D0J6HNX+jpdKlrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xpfouwIG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MXI7X8dU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Jul 2024 11:49:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720439365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BbwMPylEy43ltkm0sAu8CCcR6tMz1LHrMTFmPccd4QQ=;
	b=xpfouwIG4+ng1/ewzPRVi3CPMmhyjqCHx7BoLboUtSe9N+QTE92REgbNkOHdV2rIdKSYWs
	kEvvVnW1EziFmFZ8s8Uil0RSGW7nRP9VTfP2tRFqGyUqdJ3kEs6dUIVdRIrwh9uSWO4hbZ
	6bpixROJ5QkWDOY5Sgvi79Z4XT3pByAjoGwD45rGcDfSIC1S3/hzcwEt5GtQmoqn1Eh9sI
	S/CXR3lrGR2mrbLyK/T1eMLZJQXBt53f++JohtBO3EkwDyNWd4RkLaeAxIUllH7dzr56uX
	oKmX4EXsa7x+P5nThzqbloyelwCI1y5e/yPsVUrfBwY+lXn/cVaPyOUA4uLaCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720439365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BbwMPylEy43ltkm0sAu8CCcR6tMz1LHrMTFmPccd4QQ=;
	b=MXI7X8dU3qVdf2O+tk5ksSuFigntHWnmuPWRoTkOB0pFt7ikoYA79tfKyquf/6Dj5ZXbs5
	e1g6OjUDmup4eRBQ==
From: "tip-bot2 for Siddh Raman Pant" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Use "action" in error message to be
 consistent with help
Cc: Siddh Raman Pant <siddh.raman.pant@oracle.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172043936486.2215.15811418345178205978.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     b13e9f6da4cc34240dae05418b9876b2758ebe35
Gitweb:        https://git.kernel.org/tip/b13e9f6da4cc34240dae05418b9876b2758ebe35
Author:        Siddh Raman Pant <siddh.raman.pant@oracle.com>
AuthorDate:    Fri, 10 May 2024 15:02:57 +05:30
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 02 Jul 2024 23:40:24 -07:00

objtool: Use "action" in error message to be consistent with help

The help message mentions the main options as "actions", which is
different from the optional "options". But the check error messages
outputs "option" or "command" for referring to actions.

Make the error messages consistent with help.

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/builtin-check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 5e21cfb..387d56a 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -144,7 +144,7 @@ static bool opts_valid(void)
 	    opts.static_call		||
 	    opts.uaccess) {
 		if (opts.dump_orc) {
-			ERROR("--dump can't be combined with other options");
+			ERROR("--dump can't be combined with other actions");
 			return false;
 		}
 
@@ -159,7 +159,7 @@ static bool opts_valid(void)
 	if (opts.dump_orc)
 		return true;
 
-	ERROR("At least one command required");
+	ERROR("At least one action required");
 	return false;
 }
 

