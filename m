Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A4D383BD9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 May 2021 20:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhEQSF3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 17 May 2021 14:05:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54056 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbhEQSF3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 17 May 2021 14:05:29 -0400
Date:   Mon, 17 May 2021 18:04:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621274651;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sNzywoVAOzO/pewxEXMl6cLXtqQ+FrG4izbXPJWmYTE=;
        b=a6tDaxJ6kkoqYQKYlj516lh7bHR6hcchbaKhtXGbMk/frmQs7dpBC97QR3joxh1379FwOo
        jHHSg/4pZ2rCmifEadP5qgU33lS+i+H4YZDocH2hw4q3wmA63IWHCg+rB+PgJokRFxwmiD
        qul9sSVJA51RDDcQQrPvGn1HXxGj6qqbJxo50vfP9YO3XqvtYuCPa/rTWiGdzbi/ZUkSK9
        Dgw5KBoXfbBppVFY7LqgZHLk3ifleed32oT1MsmPb1eFlKgJEnZvxP5kV9ai/9UVgDGQmY
        H0UrkM/8/RQrf4brCkQvdnh9X7xhl09gmenoWmxcIDJMwzw4ieH3bw/fncAKRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621274651;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sNzywoVAOzO/pewxEXMl6cLXtqQ+FrG4izbXPJWmYTE=;
        b=hfDtmpK71jXMgVrQd0orlprREZTnVXHMVq79SUnL5a8MEN07HVG64Fga7Kb12bPXv0Iq+Q
        zRko0mfbrGupY0Dg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-5.13-1' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210516122217.13234-1-maz@kernel.org>
References: <20210516122217.13234-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <162127465070.29796.3524270543099967158.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     b4764905ea5b2e5314ef3aed96e1c5a5df9318c2
Gitweb:        https://git.kernel.org/tip/b4764905ea5b2e5314ef3aed96e1c5a5df9318c2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 17 May 2021 19:57:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 May 2021 19:57:47 +02:00

Merge tag 'irqchip-fixes-5.13-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull irqchip fixes from Marc Zyngier:

 - Fix PXA Mainstone CPLD irq allocation in legacy mode
 - Restrict the Apple AIC controller to the Apple platform
 - Remove a few supperfluous messages on devm_ioremap_resource() failure

Link: https://lore.kernel.org/r/20210516122217.13234-1-maz@kernel.org
---
