Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2F1407A74
	for <lists+linux-tip-commits@lfdr.de>; Sat, 11 Sep 2021 23:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhIKVMw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 11 Sep 2021 17:12:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39866 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhIKVMw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 11 Sep 2021 17:12:52 -0400
Received: from zn.tnic (p200300ec2f1e1400420cf1fb16f5b8ce.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:1400:420c:f1fb:16f5:b8ce])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D3C3E1EC051E;
        Sat, 11 Sep 2021 23:11:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631394694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aKGuNBmwERwJIuMzsnEmwXw+8G1nNb8IxmN/1AwxG/c=;
        b=e90HjM1IFsDUgU3Kqmj8sEcMWsTLcPhszhQkN8elwyAlp++ROE71h4ORIufL7z4vV9PeKq
        DBPreHZ7zGPz3sMeK+EquHOWo5nIc8zutlWg9atXVOgpzyfv3eoWz0OjsgyCotgTPcmA7z
        ypIg/p5ZRGBkUIIiN2NNVkKj1+8yI7M=
Date:   Sat, 11 Sep 2021 23:11:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org
Subject: Re: [tip: smp/urgent] thermal: Replace deprecated CPU-hotplug
 functions.
Message-ID: <YT0bej/QgXHv0UOl@zn.tnic>
References: <20210803141621.780504-20-bigeasy@linutronix.de>
 <163131391331.25758.7108415411921343282.tip-bot2@tip-bot2>
 <09f4310b-b485-e332-6fe4-bf71a9024ee1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09f4310b-b485-e332-6fe4-bf71a9024ee1@linaro.org>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sat, Sep 11, 2021 at 10:48:32PM +0200, Daniel Lezcano wrote:
> I have already this patch.

Ok, I'll hold off on sending smp/urgent Linuswards tomorrow then,
especially since he's merged your pull request already.

We can recreate that tree after -rc1 is out and do the final zap of the
deprecated CPU hotplug wrappers then.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
