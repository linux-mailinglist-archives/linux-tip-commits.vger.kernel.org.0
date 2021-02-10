Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E2A316349
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 11:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhBJKJj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 05:09:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58088 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhBJKHL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 05:07:11 -0500
Date:   Wed, 10 Feb 2021 10:06:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612951588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mPg2vAEkBYHVL3jb2y53W5cdV5EGXPMQzRwGMAdrn00=;
        b=paqqKuorW3QCrxezJzYCdNZqDXk/UBx7yZnytLlIplP0XaEED0rBHrwc5paOyynJRQtAfY
        EgHIr8MR4Vv9lC4lR4ITbhusLPvahX7g2LgVYCm02Kh9eKstFXcNpsaEYtGMllCs3UEZ/o
        hUSGVVmcGAAtVXcACYU5cmsfmTno8xKKfHsXqInChKAKbOArYlps5tcU9nOszVAc8Jt4z7
        tyneBpqsZOiYsRZBUFE3G4f/Mo7iYyE/cr7rgb0JmvgMmmbgdYP6WGiYxLK0pJ+87fI+0C
        P/mY6PnzEGDsGpLisOgC519GEbXow6at0xzvwZyoBXcwws5cOZF25VkOeiKizQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612951588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mPg2vAEkBYHVL3jb2y53W5cdV5EGXPMQzRwGMAdrn00=;
        b=FkyXCrjqPTYJyrRS22pt2q7y8gX9yJLHHsMUNNN0PYGjMPbTsW9l0GbZwTzR6Kusy1b2Md
        5P5oJrN8uBytmeCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v5.12-rc1' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3747fbde-134f-5e1d-47d5-8776c1a52aa1@linaro.org>
References: <3747fbde-134f-5e1d-47d5-8776c1a52aa1@linaro.org>
MIME-Version: 1.0
Message-ID: <161295158574.23325.12749498358516362026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     11db5710d4a954148e00e376f04ba91a498a20dd
Gitweb:        https://git.kernel.org/tip/11db5710d4a954148e00e376f04ba91a498=
a20dd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 10 Feb 2021 11:02:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Feb 2021 11:02:20 +01:00

Merge tag 'timers-v5.12-rc1' of https://git.linaro.org/people/daniel.lezcano/=
linux into timers/core

Pull clocksource/events updates from Daniel Lezcano:

 - Drop dead code on efm32 (Uwe Kleine-K=C3=B6nig)

 - Move pr_fmt() before the includes on davinci driver (Bartosz
   Golaszewski)

 - Clarified timer interrupt must be specified on nuvoton DT bindings
   (Jonathan Neusch=C3=A4fer)

 - Remove tango, sirf, u300 and atlas timer drivers (Arnd Bergman)

 - Add suspend/resume on pit64b (Claudiu Beznea)

Link: https://lore.kernel.org/r/3747fbde-134f-5e1d-47d5-8776c1a52aa1@linaro.o=
rg
---
