Return-Path: <linux-tip-commits+bounces-4449-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39975A6EBA2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11343A896E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB567254846;
	Tue, 25 Mar 2025 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uK+BxXAn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R/jAsGUk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5955C252914;
	Tue, 25 Mar 2025 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891696; cv=none; b=gZl8UCEgn9mj6K6BJGzLftBZnp6hlEcSK3h+vn+o2VDmA3tJbbYEzkmh7m1vKr1xuSYBPRDeWosE9F51k9Op6tv7csa3xmZ44R9BXjfeZCIjkydjE0iF1XbPRhrQEk3C1pmCi9KixF6Z9f8z4aVSRnHZtf4QKl06X2bJ3YWt4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891696; c=relaxed/simple;
	bh=5jFppidSCIk33bfpJ577qCVIIq+dZGtlfmZmuvjKtRQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=idDGrVrYv44i8n1KxenYtuh/dkOZw2PCHr+KgmQRcyvXISDTDdMbBSKUMVUbXyWKN00YKdnGHxO/jK+/U3nh+OW2y/GHPAYGsOeMlXswIhq5e0CqVa1BrcRDU/5deNU4wAbbnopFf6hI8NQMjWgzYlw4DUuY+S9Rs544WDnS/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uK+BxXAn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R/jAsGUk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:34:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891693;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iP26Gg7e17ExnI35dJkHFNPRQbdRUl3Oy/g38OvoHzA=;
	b=uK+BxXAngURlWgtii1miD6OyL0vVg1SDp7AmoGSzU/Hse8r/dampQqC7/PQrwU6SFwhEbj
	VOBqIhIZwWQctK3VM/d1V86Aa1U+w6pYQjO5NAkn9VNbCb1KKvD7Grfao9Ts/HkF2GpeM1
	4K5o7VP45+ZR8h8iuLc/9OlBT+gxZTSAsxlnDuYgpX5PNB7SmzZHdrmZgHrWA8OJf+N0N9
	TS5T7Xcx5489nMM8EuH8wYQnCgMXnQGWyDJil5AiF5snyXhCxy880jrmzDVWv05paP9cKN
	kGvm7D0ovk31P4y53N/qH0azo66BLqmd32bLeV41pZBBEhnodWurZMw7pEJhtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891693;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iP26Gg7e17ExnI35dJkHFNPRQbdRUl3Oy/g38OvoHzA=;
	b=R/jAsGUkDk6df4L/O6feTFhV9U7Q3oJ/VXrRFhLqSM4na8trVR7BZjW/AqrtpUQbOt4t4i
	wnGJWEcvM/YZXDCg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool, regulator: rk808: Remove potential
 undefined behavior in rk806_set_mode_dcdc()
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <2023abcddf3f524ba478d64339996f25dc4097d2.1742852847.git.jpoimboe@kernel.org>
References:
 <2023abcddf3f524ba478d64339996f25dc4097d2.1742852847.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289169296.14745.3095638819267951807.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     4d014a6b8e4dba75eb0b99e6ed990bb7e38da294
Gitweb:        https://git.kernel.org/tip/4d014a6b8e4dba75eb0b99e6ed990bb7e38da294
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:10 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:29 +01:00

objtool, regulator: rk808: Remove potential undefined behavior in rk806_set_mode_dcdc()

If 'ctr_bit' is negative, the shift counts become negative, causing a
shift of bounds and undefined behavior.

Presumably that's not possible in normal operation, but the code
generation isn't optimal.  And undefined behavior should be avoided
regardless.

Improve code generation and remove the undefined behavior by converting
the signed variables to unsigned.

Fixes the following warning with an UBSAN kernel:

  vmlinux.o: warning: objtool: rk806_set_mode_dcdc() falls through to next function rk806_get_mode_dcdc()
  vmlinux.o: warning: objtool: .text.rk806_set_mode_dcdc: unexpected end of section

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/2023abcddf3f524ba478d64339996f25dc4097d2.1742852847.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/oe-kbuild-all/202503182350.52KeHGD4-lkp@intel.com/
---
 drivers/regulator/rk808-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 7d82bd1..1e81424 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -270,8 +270,8 @@ static const unsigned int rk817_buck1_4_ramp_table[] = {
 
 static int rk806_set_mode_dcdc(struct regulator_dev *rdev, unsigned int mode)
 {
-	int rid = rdev_get_id(rdev);
-	int ctr_bit, reg;
+	unsigned int rid = rdev_get_id(rdev);
+	unsigned int ctr_bit, reg;
 
 	reg = RK806_POWER_FPWM_EN0 + rid / 8;
 	ctr_bit = rid % 8;

