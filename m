Return-Path: <linux-tip-commits+bounces-4455-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA89A6EBB0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F6116B119
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311BA2566C4;
	Tue, 25 Mar 2025 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wlxuAVHW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IrMeIDPm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90513255E49;
	Tue, 25 Mar 2025 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891702; cv=none; b=efEOZBhVe4DOROPHGcvoMJWirlchUqJcyEF1W5TyXegLe8ZTtAfQhxrGdTdInEW9hGhCV82toDsEVs3lIn2wWTVfiBk+ndFZAdLi4m3Tb4MYfPUmdi/chfawDvbU3P1aFwRzaQ3NCw8nc+V+HbbxH6k1fZKCr/2vM5+th/7khIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891702; c=relaxed/simple;
	bh=pyMwV8X0dLn0UEZH7J6QXUN2jbSV3pQJUKRI9H0vYc0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rPh5zJkgTWYfhMyygc0qzmZ8Xg3fcMpsraYP4gifVQdTrczlyhH0F/xNdmPW/L1D1/MjZjk7oRamKuBZRplz+2hwI10pubaYMIoC2YqudcOZmWD38QiD8yjMtig+2RQRybRuIjgEoNdlXRcPR2XMES4pXF84z8W9Hirl7Betjy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wlxuAVHW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IrMeIDPm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:34:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891699;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hMNmne0mY8Y7ZH+dOsMBDtkFJybZv7pk3i7vylXKzo=;
	b=wlxuAVHWsdsz3iGVorY2C/0MYykco8j+U/2jMESifsOYcybIuASOLeeXWkYOdou2xETqa6
	UuGTrpdoZsslpndWHwrl4YrOGQyv3Xuzbn18at3C03Qt8otZOZhhkFfB4QZ4Lm3/CAHhr4
	u1llWv6B7xWSeJOqZuoa+VZcHpIQnXS4uA7DzQAw/WCS56WAibVDU8GfNtcazuMTaqjBTM
	qxa6sZEfLfwtqAGokYtDEhzznjypkDcVb0AJR5asiSCEHR0YYa8oN0ArstXSkDldA6ucjU
	6O5FgZKA8K2QKTaKdLCOrohOp090lkH5FftGTqdiKDHcfN1o75c4O+XjT8UalQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891699;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hMNmne0mY8Y7ZH+dOsMBDtkFJybZv7pk3i7vylXKzo=;
	b=IrMeIDPmMBwfHjBQD2R6oM/OBftHN3OcKDEGXd8BD7TKTaBZefyYE2r+6aZKvyrSgFsNKQ
	jhAFBjfRsX3I4FBg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool, spi: amd: Fix out-of-bounds stack
 access in amd_set_spi_freq()
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Raju Rangoju <Raju.Rangoju@amd.com>,
 Mark Brown <broonie@kernel.org>,
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
Message-ID: <174289169862.14745.4727974073679138257.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     0239716b82b75dc5cb64c5ec5405dac6c3448d48
Gitweb:        https://git.kernel.org/tip/0239716b82b75dc5cb64c5ec5405dac6c3448d48
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:04 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:28 +01:00

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
Cc: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: Mark Brown <broonie@kernel.org>
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
 

