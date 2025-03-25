Return-Path: <linux-tip-commits+bounces-4544-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFFBA70C92
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 23:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13741898932
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 22:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E24269CE6;
	Tue, 25 Mar 2025 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lFLiJIQN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gAD2l+VT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B2C26980C;
	Tue, 25 Mar 2025 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742940598; cv=none; b=uFtaTTXaC1z/kIK8d/z7MfOhDHvYPS2NseauVkrlGue+utVUH1DDgurkA10fpAmPPseQzwrymF1S3Rp9U4pEwpTnFZiabKcfYVDOpE0MgmM/o3WSvTNzFFlmQAb4A3bgIMf7YNXvOPgdWv2Ainl2MxaHQtbo6QXD+Jr2JiGqQZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742940598; c=relaxed/simple;
	bh=ytDo525qPsuxXnkHP+frD+L01r79iagOhxsuKHPzOK0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gp6/vsClQYBpmK70az6HkIVMFteY9kHsqZQ3IqTnqqPClq+O5hlCMUXxRP/SVoAYuYwU70wa76+w4cgXRuFCkKke23mM77EZiNj1yJVuqIEghk0TQjYTPxuyEyk1ID5Baets3GELp49CJXMwVAiOFS4KgKAKaY/xoiT7Zx8yc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lFLiJIQN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gAD2l+VT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 22:09:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742940595;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5zVXJxyqB8WqGnjDDWOiWcd4rx18PxFhHQxr89/TAI=;
	b=lFLiJIQNojNIT0f8E628w2KbcTo1aA58MmnOGG7soK3ugNzrEFMCdB7ik7vSO/zpZJGh+Y
	t18Htn86BlrusKtNmx3BbIEI5Jlw8U32yPbgIPNEKJEkqejc3veejxTjeuMSBV78FemzFu
	QpjsTO6jB5foi5g55CDHnl5DIwfmV3NW2AtrOnv9y8g8YVDzscYxHV6EZrq35B0Qz9w8sf
	Whm5kPw6s+IcULcmEzCye7UqNPJ4CUxnGOUKsZzZY6L+U20e/Fzy537TiFJZflRSLvZiDM
	o/ryhi4HRL3Hp82/+IFA1UlWL4Bmh0hH9GIC3Sijv4FWmzsHc5WhvqATwJmHhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742940595;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5zVXJxyqB8WqGnjDDWOiWcd4rx18PxFhHQxr89/TAI=;
	b=gAD2l+VTwEFmXM3edwE/OIwtPtEXzx9g0Rx2viewNQhKPL55k+IL8wEZc9Bhe8Zg3YLITw
	ZKf47TEaUSk3tBDQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool, regulator: rk808: Remove potential
 undefined behavior in rk806_set_mode_dcdc()
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
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
Message-ID: <174294059450.14745.18117830484664150420.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     29c578c848402a34e8c8e115bf66cb6008b77062
Gitweb:        https://git.kernel.org/tip/29c578c848402a34e8c8e115bf66cb6008b77062
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:10 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 23:00:29 +01:00

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
Acked-by: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
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

