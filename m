Return-Path: <linux-tip-commits+bounces-4550-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2760FA70CA0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 23:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25F817A83E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 22:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EFE26A1B8;
	Tue, 25 Mar 2025 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jYcR0M/a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dEgqV6Pw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B2226A0EA;
	Tue, 25 Mar 2025 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742940604; cv=none; b=Co/VUfA+ZyiUVBg4Jo5I6hAoo49NE5SsKB0IPilMcVOh5yLmgiI8sBAgNKQ1iUuvUvYpxbYV0ZJWnuKapxqQ61iR9c9LL6aPWfSgZjEXWxJMWZO+cXnbof5uz/DLfeEzzEn8wUiQTC1MYmG6Mvn73Lqf7dOyCCKuXxQ1Lx+73r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742940604; c=relaxed/simple;
	bh=YdUbScf68uKSvmmNBID0unomYwPo6TWuZk/j2Vc0qrE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k0f/PzAQmtUMGdjgbakZZdQdHtX4YvE3JWCsmzxiWBQcJjU6g/efXim8MAQwPG7sWL3LsfakzTQxk0OP8HzwTPICGef23VsXh6Qs5YjBQkvPkqRdJoKrJfnnGcW3E/rIuJ2hZzmdyvXgLMUr1n0h03//vI4nmPrUkWVhI86TLhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jYcR0M/a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dEgqV6Pw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 22:10:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742940600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khg9tQsGOz8f7tU5JSPhmE9SNOc+uuTcJWc7D9Awcqs=;
	b=jYcR0M/adntFIQc9uyFOlApQUiROVjlT9UldAWJQLLoloB/tsNScOA5a0yzhF0Xd6QNhVO
	0TrPC8gY3rRD4z6fblAE6fdQD5rxjOSKSLjPbs6z5eUtNFX10sqYwG9crbqt01UDbHmRoE
	MaSTzN6B1dh1kgXXvbsygAoTRG0YShGHaf0Q3qKAaAAK19evt3M9NbtSjZzhkFNBs/M/lr
	YLsh4H9bK1XaEfJrnoYwm3WNupgqfauKcxA7OEdbCd8Eu2e6CVXXJrLcu6nR87cTXt2+LO
	qIamrRvW4/TSCckV1qfm0NDbbQkLEmYJmMemghAxLhTzuOfXsfptpmE1oLS6iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742940600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khg9tQsGOz8f7tU5JSPhmE9SNOc+uuTcJWc7D9Awcqs=;
	b=dEgqV6PwKk3InmyXCvBk6gV7Kb25Ld0yq8gKR96UIo0BvjFs6KxvdG7hLSwbc4uF3yXwRe
	JfCDtTWhQuoJfXBw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool, spi: amd: Fix out-of-bounds stack
 access in amd_set_spi_freq()
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Mark Brown <broonie@kernel.org>,
 Raju Rangoju <Raju.Rangoju@amd.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <78fef0f2434f35be9095bcc9ffa23dd8cab667b9.1742852847.git.jpoimboe@kernel.org>
References:
 <78fef0f2434f35be9095bcc9ffa23dd8cab667b9.1742852847.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174294060018.14745.1774182983307255027.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     76e51db43fe4aaaebcc5ddda67b0807f7c9bdecc
Gitweb:        https://git.kernel.org/tip/76e51db43fe4aaaebcc5ddda67b0807f7c9bdecc
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:04 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 23:00:03 +01:00

objtool, spi: amd: Fix out-of-bounds stack access in amd_set_spi_freq()

If speed_hz < AMD_SPI_MIN_HZ, amd_set_spi_freq() iterates over the
entire amd_spi_freq array without breaking out early, causing 'i' to go
beyond the array bounds.

Fix that by stopping the loop when it gets to the last entry, so the low
speed_hz value gets clamped up to AMD_SPI_MIN_HZ.

Fixes the following warning with an UBSAN kernel:

  drivers/spi/spi-amd.o: error: objtool: amd_set_spi_freq() falls through to next function amd_spi_set_opcode()

Fixes: 3fe26121dc3a ("spi: amd: Configure device speed")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Mark Brown <broonie@kernel.org>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/78fef0f2434f35be9095bcc9ffa23dd8cab667b9.1742852847.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/r/202503161828.RUk9EhWx-lkp@intel.com/
---
 drivers/spi/spi-amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index c859974..17fc0b1 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -302,7 +302,7 @@ static void amd_set_spi_freq(struct amd_spi *amd_spi, u32 speed_hz)
 {
 	unsigned int i, spd7_val, alt_spd;
 
-	for (i = 0; i < ARRAY_SIZE(amd_spi_freq); i++)
+	for (i = 0; i < ARRAY_SIZE(amd_spi_freq)-1; i++)
 		if (speed_hz >= amd_spi_freq[i].speed_hz)
 			break;
 

