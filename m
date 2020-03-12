Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F593183250
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Mar 2020 15:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgCLOFp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Mar 2020 10:05:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59709 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727123AbgCLOFo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Mar 2020 10:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584021943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/QcQ9yaW2B9Sro10c4GCfJinEur6UPsaYYhw3gFWCo=;
        b=RdAmPlwrJIkeN/k5xNUMxUWpYFP9Ia5qOz6TVs6zJN4W08G2dCZOXsS/0BXDGsc7MJnZqD
        ItIxcOZkzOI1oCC/wnDG/dYan+sBwedm7LN2V+/C5HMmf3A5whK//snxfjFPnVumxq4GBe
        fE2T0PVRZkVWMkqlWjxWADJElsA3dzU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-8y1vAQ5aMTiLvGz4J9xIgA-1; Thu, 12 Mar 2020 10:05:41 -0400
X-MC-Unique: 8y1vAQ5aMTiLvGz4J9xIgA-1
Received: by mail-wr1-f71.google.com with SMTP id l16so1941536wrr.6
        for <linux-tip-commits@vger.kernel.org>; Thu, 12 Mar 2020 07:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T/QcQ9yaW2B9Sro10c4GCfJinEur6UPsaYYhw3gFWCo=;
        b=gq3+ZuggjXP4N/NibUVPs791PjEp/pRmvliSqpbegb7e/TRNQjy/d6+JA6OpnO9khR
         EZc9+7OcnCxJEW7fqrEDe3hU/pJDCb/PlSR9qjGb8KGRiJQfQyMIkSb0L0r83j7q1E6f
         tNU0sdAZgUPxPO3B3UKsfwLSjUdatSlTJMsfNeljlu4u0bhAGFpm/Z88LSXl8bK/ZYpx
         rVZ2YusTPnK68VA2RuNssi8xdB8WX0pmT+IhzO843NY1KTdeactlVkGfNRS5XawgXy9y
         v2YQ8UQkfhXvG2XwJnz08Tdemh/v+imLPrJbQtR4A2n/ozfvAp/UI1XNomVxZCoEECrq
         ZMJA==
X-Gm-Message-State: ANhLgQ0ZzYmsf5LS6N2zExC/tCzt5yvkiwh3XTBl59bjDX2ZgdWOTg1d
        nj+FkkixYKy7zpgpoL9HqknnfdIjGBeDZQaxl+lHynL9XdL9ymi0d2sGWBNsrAWuqsDwJCYxcUP
        Vu1ZHryy5W5CdW3WF6j+KIOdPtJKAvv4=
X-Received: by 2002:a1c:26c4:: with SMTP id m187mr4956719wmm.43.1584021940555;
        Thu, 12 Mar 2020 07:05:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs4Ui/zFpmKBS9lbKSRR8lfOVrW1lT7LfaM80YHNXUVW7ArWydh/3x3vNaetG6WKUr0t32dAw==
X-Received: by 2002:a1c:26c4:: with SMTP id m187mr4956687wmm.43.1584021940203;
        Thu, 12 Mar 2020 07:05:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id k133sm12979071wma.11.2020.03.12.07.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 07:05:39 -0700 (PDT)
Subject: Re: [tip: irq/core] x86: Select HARDIRQS_SW_RESEND on x86
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
References: <20200123210242.53367-1-hdegoede@redhat.com>
 <158396292503.28353.1070405680109587154.tip-bot2@tip-bot2>
 <CACRpkdYPy93bDwPe1wHhcwpgN9uXepKXS1Ca5yFmDVks=r0RoQ@mail.gmail.com>
 <1cb0397f-e583-3d7e-dff3-2cc916219846@redhat.com>
 <CACRpkdb7vxSaK1Df6gNX_Kq-LF=S1qx2iKdmBy1Ku0vEpDVPbA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <231875e7-fc72-edb4-a4de-fc7cfc3cdca3@redhat.com>
Date:   Thu, 12 Mar 2020 15:05:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdb7vxSaK1Df6gNX_Kq-LF=S1qx2iKdmBy1Ku0vEpDVPbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hi,

On 3/12/20 3:02 PM, Linus Walleij wrote:
> On Thu, Mar 12, 2020 at 2:49 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 
> [Me]
>>> I see that ARM and ARM64 simply just select this. What
>>> happens if you do that and why is x86 not selecting it in general?
>>
>> Erm, "selecting it in general" (well at least on x86) is what
>> this patch is doing.
> 
> Sorry that I was unclear, what I meant to say is why wasn't
> this done ages ago since so many important architectures seem
> to have it enabled by default.
> 
> I suppose the reason would be something like "firmware/BIOS
> should handle that for us" and recently that has started to
> break apart and x86 platforms started to be more like ARM?

That (x86 becoming more like ARM, sorta, kinda) as well as
that turning it on on x86 was not safe until Thomas wrote
the 2 patches which are marked as dependencies in the commit
message for this patch.

Regards,

Hans

