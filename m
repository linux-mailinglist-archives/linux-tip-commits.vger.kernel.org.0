Return-Path: <linux-tip-commits+bounces-4453-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF19A6EBAB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8BD1894FAE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670D8255E3C;
	Tue, 25 Mar 2025 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1LDio7Tt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BzJjQyEM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C49254B0A;
	Tue, 25 Mar 2025 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891700; cv=none; b=Y6DKdE2FegnQpTJydFIXxw52cdCY4XittfY6sjny7B+tzpn6Gjl0dcU+k3HDtN5yfxFbOkZLlWLWBC3efJV/pspd8JfT6OU3yOP/2Ht6L4WJUdVvLicUdDPbiqPsU9Byqx+87p0+PgtZAM7XKXViyawC7Gp21iCFEC40F1+lAck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891700; c=relaxed/simple;
	bh=+TP3IYNBisGnY+XFZUxvVs6+69EcFGI/3NYkZHLrUxY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ojtrAaOqh+nRxYPfrEFFz56JjhqumpOm+BZTuVS5PVVkuweFyTtgf6/wTt/6MhurLCSTbDcHw0IsXxEJz1o8J7ghe+0QvrXGaG0JNrTCgjLrhYScwxkuopQpv2PQY49t61GVmG3VT6AQCaA4AvjfPcnE93uxBvgoiCrrNrdC3aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1LDio7Tt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BzJjQyEM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:34:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891697;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dF8VHu1ElYBbbCaZXr3a+8+R5bVYpdV4cnq1iH+/gCU=;
	b=1LDio7Ttq8YkH/WZ2oazUgm5BqLdMRMrqwom/nRCHwOB38+/D8W+P251uLc+NJ2BPLMHH3
	vn9zDbp/mBwRoGV/jn5CcBuxvhfOkE2GUJyVRCITURNsWHyWOFDj0jdpRicPPGwAaOtNeg
	eGP9J9zy5eUZr0o7cfZQ2bj/X4/Dpe/f65T0zDx8OsyFjyGMcavc+6HmB8F7Z+cw0kDnXu
	kvjEPBRil7II3puBVpGyC8Ce4q0IUssoEI3fEAH2yC3uGbC0nIQdFnUAAqd50y3IOKAyPC
	jNsT8DUZlNXaaC0QhzPLI67FFcMKLwaKzpwOBWoCS1KA8IX8v8JnoaR8g+zZLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891697;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dF8VHu1ElYBbbCaZXr3a+8+R5bVYpdV4cnq1iH+/gCU=;
	b=BzJjQyEMZAfeILTes5FsSWpmUkOSeXfiT+znKqByxwSEfC/Ez6GQnB3VXu/W4EVAHf816Y
	mpAomXYro1/XMkAg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool, media: dib8000: Prevent divide-by-zero
 in dib8000_set_dds()
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <bd1d504d930ae3f073b1e071bcf62cae7708773c.1742852847.git.jpoimboe@kernel.org>
References:
 <bd1d504d930ae3f073b1e071bcf62cae7708773c.1742852847.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289169650.14745.15081186274807925051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     c13d957b38b43cfee77f210c2f6c64c2957afed0
Gitweb:        https://git.kernel.org/tip/c13d957b38b43cfee77f210c2f6c64c2957afed0
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:06 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:28 +01:00

objtool, media: dib8000: Prevent divide-by-zero in dib8000_set_dds()

If dib8000_set_dds()'s call to dib8000_read32() returns zero, the result
is a divide-by-zero.  Prevent that from happening.

Fixes the following warning with an UBSAN kernel:

  drivers/media/dvb-frontends/dib8000.o: warning: objtool: dib8000_tune() falls through to next function dib8096p_cfg_DibRx()

Fixes: 173a64cb3fcf ("[media] dib8000: enhancement")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/bd1d504d930ae3f073b1e071bcf62cae7708773c.1742852847.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/r/202503210602.fvH5DO1i-lkp@intel.com/
---
 drivers/media/dvb-frontends/dib8000.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
index 2f51659..cfe59c3 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -2701,8 +2701,11 @@ static void dib8000_set_dds(struct dib8000_state *state, s32 offset_khz)
 	u8 ratio;
 
 	if (state->revision == 0x8090) {
+		u32 internal = dib8000_read32(state, 23) / 1000;
+
 		ratio = 4;
-		unit_khz_dds_val = (1<<26) / (dib8000_read32(state, 23) / 1000);
+
+		unit_khz_dds_val = (1<<26) / (internal ?: 1);
 		if (offset_khz < 0)
 			dds = (1 << 26) - (abs_offset_khz * unit_khz_dds_val);
 		else

