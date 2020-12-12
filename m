Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE522D8685
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438948AbgLLNA1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438932AbgLLNAK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 08:00:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E44C061282;
        Sat, 12 Dec 2020 04:58:44 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uj4oOQ4noc158R3TXE/+cPOZp2aDOMlQ4jU/bdaZYos=;
        b=H0HX2KrjILEkCDPpcEGGJb1UiWfMPpgtULJ+VbYh503y/DlFNmwf8747cnHPjEiQhBM5ZO
        8qQATXBTtobswriTufgm9Xh6FLq47hQY19tE+y+hFw3itUS1gCEweiVcYSsZtMCdfu0X3v
        kgvVbgcWMa1koS4WNHT0TL5z1inFcDm0ARykLsyhyYLAKktrmoJ3LlUZsD95b7sWYB2rvl
        6mCiUk0oUOUZB0PwR1m3h6uRZx528FJecAR2fHalLLlukCXksssdnG7bSmGmOrwsM79pFK
        Ak893nxjBwndfYEDassDH4GoHXGIgGYqnEXbu2YRShyZQcNOW//z4ZBD8N02rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uj4oOQ4noc158R3TXE/+cPOZp2aDOMlQ4jU/bdaZYos=;
        b=Ewx8Ju/l+jnCrxZRudW+zsO4rRexAycQ+MadDClzcLKWcF0cD+2PjN57ZelrUHzotel3W7
        h2CmGBw9Rr6Ah1BQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] drm/i915/lpe_audio: Remove pointless irq_to_desc() usage
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        ville.syrjala@linux.intel.com, Jani Nikula <jani.nikula@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194043.862572239@linutronix.de>
References: <20201210194043.862572239@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791878.3364.1801400207641504053.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     766ba1f937be5ec418bd759e40fccc0c8c42e271
Gitweb:        https://git.kernel.org/tip/766ba1f937be5ec418bd759e40fccc0c8c4=
2e271
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:04 +01:00

drm/i915/lpe_audio: Remove pointless irq_to_desc() usage

Nothing uses the result and nothing should ever use it in driver code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Link: https://lore.kernel.org/r/20201210194043.862572239@linutronix.de

---
 drivers/gpu/drm/i915/display/intel_lpe_audio.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_lpe_audio.c b/drivers/gpu/drm=
/i915/display/intel_lpe_audio.c
index ad5cc13..1c939f9 100644
--- a/drivers/gpu/drm/i915/display/intel_lpe_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_lpe_audio.c
@@ -297,13 +297,9 @@ int intel_lpe_audio_init(struct drm_i915_private *dev_pr=
iv)
  */
 void intel_lpe_audio_teardown(struct drm_i915_private *dev_priv)
 {
-	struct irq_desc *desc;
-
 	if (!HAS_LPE_AUDIO(dev_priv))
 		return;
=20
-	desc =3D irq_to_desc(dev_priv->lpe_audio.irq);
-
 	lpe_audio_platdev_destroy(dev_priv);
=20
 	irq_free_desc(dev_priv->lpe_audio.irq);
