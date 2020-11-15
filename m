Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6712B3A72
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Nov 2020 23:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgKOWwJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 15 Nov 2020 17:52:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37548 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgKOWwJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 15 Nov 2020 17:52:09 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605480727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/eDU4LroO7PYbFgMq6JRhzipnWtkFc9jYZysBKLqo6Y=;
        b=m4mcdIendMIAnzCvjzB1rKiLDhMePzMj9yhGaKi7wQJrCDEQwM+ipMz2GdXgMmHEXKkOq4
        pkaojbZ/PRmUn/aYegFO3fkiZsxyby9Ci1S2kMPeNKN3Kb6PRMNib7AZP7HOr7Y4PvfDZ5
        sQ/g2iMNutuWWSsSq6rLtPbQrrw992BroPnxAI5xY1uPcXdjXgCTC2KN0NEA9+6DGNHKxb
        rGcpyjekwdVXDnUYDJTKSWtUf0SP+AzHqhDUw3Z+7CnYihutJE9m5WDTa2iPeVVd5cKYhd
        Pl6zRKA31UB7V8nh7GsrbUx1FjzsMkA+65bt/kSxHeGfV3TTVgXIIuxSEAH7+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605480727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/eDU4LroO7PYbFgMq6JRhzipnWtkFc9jYZysBKLqo6Y=;
        b=6TGwwNeOxyM6hVDkLnwtgC8zP5E0KAVVOw4sYSD7ma3+8+QVAyg9wN5UUo02VnQSjquhoB
        FvvMBpBQx+8JCeCA==
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org
Subject: Re: [tip: core/entry] entry: Fix spelling/typo errors in irq entry code
In-Reply-To: <7cb2266c9056f0106c5a870f741691143fcd0a77.camel@perches.com>
References: <20201104230157.3378023-1-ira.weiny@intel.com> <160546656898.11244.12849621903409820578.tip-bot2@tip-bot2> <7cb2266c9056f0106c5a870f741691143fcd0a77.camel@perches.com>
Date:   Sun, 15 Nov 2020 23:52:07 +0100
Message-ID: <87tutq44iw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sun, Nov 15 2020 at 11:08, Joe Perches wrote:

> On Sun, 2020-11-15 at 18:56 +0000, tip-bot2 for Ira Weiny wrote:
>> The following commit has been merged into the core/entry branch of tip:
> []
>> s/assemenbly/assembly/
> []
>> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> []
>> @@ -438,7 +438,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct p=
t_regs *regs);
>> =C2=A0=C2=A0* @regs:	Pointer to pt_regs (NMI entry regs)
>> =C2=A0=C2=A0* @irq_state:	Return value from matching call to irqentry_nm=
i_enter()
>> =C2=A0=C2=A0*
>> - * Last action before returning to the low level assmenbly code.
>> + * Last action before returning to the low level assmebly code.
>
> Might want to fix that typo typo fix...

Bah ....
