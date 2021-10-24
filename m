Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF65438A0D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Oct 2021 17:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhJXPmm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Oct 2021 11:42:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49384 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbhJXPma (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Oct 2021 11:42:30 -0400
Date:   Sun, 24 Oct 2021 15:40:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635090009;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qKvy48OEWIyGRe2I65MWCqJxFfDh/RL3SLKzktls+co=;
        b=YDiHcVi0r2952t4sCMdDbfhVLKZTE+1Is97DSg0SAHRqq+g6mHBjYnjepAv35+nM+fpfvO
        aIrpBPtPbhUwb+12n9w1jKPGS3jofLneuAAsvS7qVrgXfuc/3Y4z/NzyDlkFBifHCOXqYa
        PliQeopDtXUXWEVdlSKY+tjhHOv8ZMOsjb1z3TIhhkzLKNYYhy1JLHBqPZ0aRcKFtKVRCH
        NycxhiqX0soz41QNiBPZepzZ6C3SN1GNFcQCa6U9gQ4PfvZRNlrif5cG6sBKuReoS2bjNA
        vjh6hLvEOBGw4Hwx5fg2fz+lkpkaL0w81ZKaIAc0tqnLQcgFzf4TU9D3UZC7rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635090009;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qKvy48OEWIyGRe2I65MWCqJxFfDh/RL3SLKzktls+co=;
        b=ru4nAkjQaKJvCEQbwPmci6oH0JPKPR2rE0haxXS4dUigUUy1Cj+25mOZZEXqJ1tD9kcWVc
        ncE651JTSysYjgBg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v5.16-rc1' into timers/core
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <65693aaf-ab94-c9bb-a97b-a2bb77033a54@linaro.org>
References: <65693aaf-ab94-c9bb-a97b-a2bb77033a54@linaro.org>
MIME-Version: 1.0
Message-ID: <163509000813.626.2979020151942704160.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a8da61cee95e627ed3d4274861428013aa9604ea
Gitweb:        https://git.kernel.org/tip/a8da61cee95e627ed3d4274861428013aa9604ea
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sun, 24 Oct 2021 17:14:23 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 24 Oct 2021 17:14:23 +02:00

Merge tag 'timers-v5.16-rc1' into timers/core

Pull timers update for v5.16 from Daniel Lezcano:

- Fix redefined macro in the arc timer ()

- Big cleanup for ARM arch timer clocksource in order to set the scene
  for ARMv8.6 and provide support for higher frequencies with longer
  roll up (Marc Zyngier)

- Make arch dependant the Exynos MCT and Samsung PWM timers (Krzysztof
  Kozlowski)

- Select the TIMER_OF option for the timer TI DM (Kees Cook)

Link: https://lore.kernel.org/r/65693aaf-ab94-c9bb-a97b-a2bb77033a54@linaro.org
Signed-off-by: Borislav Petkov <bp@suse.de>
---
